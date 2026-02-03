extends Control

@onready var scoreLabel = $HBoxContainer2/ScoreVBOX/ScorePlayer
@onready var multLabel = $HBoxContainer2/MultVbox/MultPlayer
@onready var timeLabel = $HBoxContainer2/TimerVbox/TimerPlayer
@onready var lifeLabel = $HBoxContainer2/LifeVbox/lifePlayer

var hp: Array[TextureRect]

func _ready():
	offset_left = 0
	offset_top = 0
	offset_right = 0
	offset_bottom = 0
	var hprect = $TextureRect/HBoxContainer
	# all children = Hp icons
	for child in hprect.get_children():
		hp.append(child)
	
func damage(newHP):
	updatehp(newHP)
	# ADD OTHER STUFF LIKE SOUND EFFECTS, ANIMATIONS ETC.
	

func updatehp(newHP):
	for i in range(hp.size()):
		hp[i].visible = i< newHP

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
	
