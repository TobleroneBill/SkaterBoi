extends Node3D

# Level Refrences
@onready var Typer = $Typer			# what shows the typing words
@onready var Cam = $Camera3D		# camera effects
@onready var Player = $Player
@onready var ScoreTimer = $Timer 	# how long until the next word

@export var mediumThreshold: int = 5
@export var hardThreshold: int = 15
@export var extremeThreshold: int = 30


# Scoring
var Score: float = 0
var Multiplier: int = 1
var AddScore: int = 100	#score that gets added on a successful spelling
var CorrectStreak: int = 0

var wordlist

# Test words to use
#var words = [
	#"cool",
	#"radical",
	#"guns",
	#"dmc",
	#"gary"
#]

# Letter variables
@export var CurrentWord: String
var LetterIndex: int = 0

# difficulty = easy,medium,hard,extreme - access that word group
func changewordlist(difficulty):
	match difficulty:
		"easy":
			wordlist = Global.GameManager.wordlist.easy
		"medium":
			wordlist = Global.GameManager.wordlist.medium
		"hard":
			wordlist = Global.GameManager.wordlist.hard
		"extreme":
			wordlist = Global.GameManager.wordlist.extreme

func _ready():
	changewordlist("easy")
	SetNewWord()

#Set the new word to write
func SetNewWord():
	CurrentWord = wordlist.pick_random()
	print('new word is: ' + CurrentWord)
	Typer.Update(CurrentWord)
	LetterIndex = 0

## Keyboard Checks
# Key Checking
func _input(event):
	if event is InputEventKey and event.pressed:
		#print(event.as_text_keycode())
		if event.as_text_keycode() == "":
			return
		# If correct letter pressed
		if CurrentWord[LetterIndex].to_lower() == event.as_text_keycode().to_lower() or CurrentWord[LetterIndex].to_lower() in [" "]:
			Typer.Update(CurrentWord,CurrentWord.substr(0, LetterIndex+1))
			if LetterIndex != len(CurrentWord)-1:
				LetterIndex+=1
			else: ## Correct word completed
				ScoreTimer.start()
				Score += (AddScore * Multiplier)
				CorrectStreak+=1 
				if CorrectStreak == Multiplier:
					# increase multiplier and reset the streak
					Multiplier += 1
					CorrectStreak = 0
				SetNewWord()
				print("Score: "+ str(Score))
		else: # failed
			SetNewWord()
			# reset multiplier on failure
			CorrectStreak = 0
			Multiplier = 1
