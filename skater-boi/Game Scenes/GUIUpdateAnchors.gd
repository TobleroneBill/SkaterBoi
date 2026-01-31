extends Control

@onready var scoreLabel = $HBoxContainer/ScoreVBOX/ScorePlayer
@onready var multLabel = $HBoxContainer/MultVbox/MultPlayer
@onready var timeLabel = $HBoxContainer/TimerVbox/TimerPlayer
@onready var lifeLabel = $HBoxContainer/LifeVbox/lifePlayer

func _ready():
	offset_left = 0
	offset_top = 0
	offset_right = 0
	offset_bottom = 0

func UpdateScore(newscore):
	scoreLabel.text = str(int(newscore))
	
func UpdateMult(newmult):
	multLabel.text = str(newmult)

func UpdateTimer(newtime):
	timeLabel.text = str(newtime)
	
func UpdateLife(newlife):
	lifeLabel.text = str(newlife)

func UpdateBoth(newscore,newmult):
	UpdateScore(newscore)
	UpdateMult(newmult)
	
