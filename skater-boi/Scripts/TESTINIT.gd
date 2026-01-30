extends Node3D

# Level Refrences
@onready var Typer = $Typer
@onready var Cam = $Camera3D
@onready var Player = $Player
@onready var ScoreTimer = $Timer

# Scoring
var Score = 0
var Multiplier = 1
@export var AddScore = 100	#score that gets added on a successful spelling

# Test words to use
var words = [
	"cool",
	"cowabunga",
	"radicool"
]

# Letter variables
@export var CurrentWord: String
var LetterIndex: int = 0

func _ready():
	SetNewWord()

#Set the new word to write
func SetNewWord():
	CurrentWord = words.pick_random()
	print('new word is: ' + CurrentWord)
	Typer.Update(CurrentWord)
	LetterIndex = 0

## Keyboard Checks
# Key Checking
func _input(event):
	if event is InputEventKey and event.pressed:
		print(event.as_text_keycode())
		if event.as_text_keycode() == "":
			return
		# If correct letter pressed
		if CurrentWord[LetterIndex].to_lower() == event.as_text_keycode().to_lower():
			Typer.Update(CurrentWord,CurrentWord.substr(0, LetterIndex+1))
			if LetterIndex != len(CurrentWord)-1:
				LetterIndex+=1
			else: ## Correct word completed
				ScoreTimer.start()
				Global.GameManager.ChangeGUI("res://Game Scenes/score_gui.tscn")
				SetNewWord()
		else:
			SetNewWord()
