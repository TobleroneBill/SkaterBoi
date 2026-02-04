extends Node3D

# Level Refrences
@onready var Typer = $Typer			# what shows the typing words
@onready var Cam = $Camera3D		# camera effects
@onready var Player = $Player
@onready var Soundplayer = $SoundEffects

# When to swtich wordlists
@export var mediumThreshold: int = 5
@export var hardThreshold: int = 15
@export var extremeThreshold: int = 30

# Scoring
var CorrectStreak: int = 0
var Multiplier: int = 1
var AddScore: int = 100	#score that gets added on a successful spelling
var difficulty = "easy"
@export var lives: int = 5

var HighestMult = 1
var Score: float = 0
var totalwords: int = 0

# Timer Settings
@onready var wordTimer = $wordTimer 	# how long until to completeword
@onready var newwordTimer = $newwordTimer 	# how long until to completeword
var cantype = true

@export var timervarianceDelta = 1 # the amount of randomized add/minus time to make things less predictable
@export var wordtimerReset = 4

@onready var playerAnimator = $Player/AnimationPlayer
@export var ntMinMax = {
	"min": 2,
	"max": 5
}

# the pool of words we draw from
var wordlist

func playerAnis(aniName):
	match aniName:
		"hit":
			playerAnimator.play("Die")
			$"Player/Position Animator".play("DieBack")
		"alive":
			playerAnimator.play("Alive")
			$"Player/Position Animator".play("AliveForward")	
	

# Letter variables
@export var CurrentWord: String
var LetterIndex: int = 0

# difficulty = easy,medium,hard,extreme - access that word group
func changewordlist(difficulty):
	match difficulty:
		"easy":
			wordlist = Global.GameManager.wordlist.easy
			wordtimerReset = 4
			Typer.position = $Typerpos1.position
			$Music.stream = load("res://Audio/Music/Difficutly Music 2/Easy.wav")
			
		"medium":
			wordlist = Global.GameManager.wordlist.medium
			wordtimerReset = 4
			Typer.position = $Typerpos1.position
			$Music.stream = load("res://Audio/Music/Difficutly Music 2/Med.wav")
		"hard":
			wordlist = Global.GameManager.wordlist.hard
			wordtimerReset = 5
			Typer.position = $Typerpos1.position
			$Music.stream = load("res://Audio/Music/Difficutly Music 2/Hard.wav")
			
		"extreme":
			wordlist = Global.GameManager.wordlist.extreme
			wordtimerReset = 7
			Typer.position = $Typerpos2.position
			$Music.stream = load("res://Audio/Music/Difficutly Music 2/ext.wav") 
	$Music.play()

func _ready():
	playerAnimator.play("IDLE")
	changewordlist("easy")
	SetNewWord()
	$Music.play()

#Set the new word to write
func SetNewWord():
	var newword = wordlist.pick_random()
	while newword == CurrentWord:
		newword = wordlist.pick_random()
	CurrentWord = newword
	Typer.Update(CurrentWord)
	LetterIndex = 0
	wordTimer.start(wordtimerReset)

func _physics_process(delta):
	if randi_range(0,100000) < 150:
		playerAnimator.play("Wobble")
		
	
	# check for normal GUI, and if so update its text
	if len(Global.GameManager.GUI.get_children()) == 1:
		if Global.GameManager.GUI.get_children()[0].has_method("UpdateBoth"):
			#Global.GameManager.GUI.get_children()[0].UpdateLife(int(lives))
			Global.GameManager.GUI.get_children()[0].UpdateBoth(Score,Multiplier)
			#if Multiplier<1:
			if CorrectStreak !=0:
				var streakProgress = float(CorrectStreak)/float(Multiplier)
				Global.GameManager.GUI.get_children()[0].MultLevelProgress(streakProgress*100)
			else:
				Global.GameManager.GUI.get_children()[0].MultLevelProgress(0)
			
	
	# Update the Typer Timer
	var percentageTime = (wordTimer.time_left / wordtimerReset) * 100
	Typer.setProgress(percentageTime)

func typingsound():
	Soundplayer.stream = Global.type_sounds.pick_random()
	Soundplayer.pitch_scale = randf_range(.8,1.2)
	Soundplayer.play()

func hit():
	playerAnis("hit")
	$Player/Damage.play()
	$Player/Skating.stop()
	lives -= 1
	Global.GameManager.GUI.get_children()[0].damage(lives)
	
	if lives <= 0:
		print(HighestMult)
		print(Score)
		print(totalwords)
	
		#set Session Variables
		Global.GameManager.sessionMult = HighestMult
		Global.GameManager.sessionScore = Score
		Global.GameManager.sessionwords = totalwords
		
		#Check Hiscores
		
		Global.GameManager.Change3D("res://Game Scenes/LoseScene/lose_bg.tscn")
		Global.GameManager.ChangeGUI("res://Game Scenes/LoseScene/failscreen.tscn")
		print('died')

## Keyboard Checks
# Key Checking
func _input(event):
	if event is InputEventKey and event.pressed and cantype:
		if event.as_text_keycode() == "":
			return
		# If correct letter pressed
		if CurrentWord[LetterIndex].to_lower() == event.as_text_keycode().to_lower() or CurrentWord[LetterIndex].to_lower() in [" "]:
			typingsound()
			Typer.Update(CurrentWord,CurrentWord.substr(0, LetterIndex+1))
			if LetterIndex != len(CurrentWord)-1:
				LetterIndex+=1
			else: ## !!!Correct!!!
				totalwords +=1
				wordTimer.start(wordtimerReset)
				Score += (AddScore * Multiplier)
				CorrectStreak+=1 
				if CorrectStreak == Multiplier:
					match Multiplier:
						mediumThreshold:
							changewordlist("medium")
						hardThreshold:
							changewordlist("hard")
						extremeThreshold:
							changewordlist("extreme")
					# increase multiplier and reset the streak
					Multiplier += 1
					CorrectStreak = 0
					$S_GETMULT.play()
				else:
					$S_GETPOINTS.play()
				SetNewWord() # start the next word & restart timer
				print("Score: "+ str(Score))
		else: # !!!failed!!!
			# Start the reset timer & disable typing
			newwordTimer.start(wordtimerReset)
			cantype = false
			Typer.Fadeout()
			# reset multiplier & go back to easy words on failure 
			if Multiplier > HighestMult:
				HighestMult = Multiplier
			
			CorrectStreak = 0
			Multiplier = 1
			hit()
			wordTimer.stop()
			changewordlist("easy")
			

func _on_word_timer_timeout():
	newwordTimer.start(wordtimerReset)
	changewordlist("easy")
	Typer.Fadeout()
	cantype = false
	hit()
	print("timer ran out")

func _on_newword_timer_timeout():
	SetNewWord() # start the next word after the max timeout
	cantype = true
	Typer.reset()
	playerAnis("alive")
	$Player/Skating.play()
	

func _on_music_finished():
	$Music.play()


func _on_audio_stream_player_3d_finished():
	$Player/Skating.play()
