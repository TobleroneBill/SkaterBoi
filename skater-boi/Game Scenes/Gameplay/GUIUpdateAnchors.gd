extends Control

#@onready var scoreLabel = $HBoxContainer2/ScoreVBOX/ScorePlayer
@onready var multLabel = $PanelContainer/VBoxContainer/HBoxContainer/MultLabel
@onready var scoreLabel = $PanelContainer/VBoxContainer/Score

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

func MultLevelProgress(percent):
	#print(percent)
	$PanelContainer/VBoxContainer/ProgressBar.value = percent

func updatehp(newHP):
	for i in range(hp.size()):
		hp[i].visible = i< newHP

func UpdateMult(newmult):
	multLabel.text = str(newmult)
	
func UpdateScore(newscore):
	scoreLabel.text = str(newscore)

func UpdateBoth(newscore,newmult):
	UpdateMult(newmult)
	UpdateScore(newscore)
