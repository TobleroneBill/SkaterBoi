extends Control

func _on_button_pressed():
	Global.GameManager.Change3D("res://Game Scenes/Gameplay/Gameplay.tscn")
	Global.GameManager.ChangeGUI("res://Game Scenes/Gameplay/score_gui.tscn")

var sessionrank: String

# when Dying, score details get stored in gamemanager for refrence here
# Might need tweaking
func GetRank():
		if Global.GameManager.sessionScore <=5000:
				sessionrank = "D"
		elif Global.GameManager.sessionScore> 5000 and Global.GameManager.sessionScore<=10000:
				sessionrank = "C"
		elif Global.GameManager.sessionScore> 10000 and Global.GameManager.sessionScore<=20000:
				sessionrank = "B"
		elif Global.GameManager.sessionScore> 20000 and Global.GameManager.sessionScore<=40000:
				sessionrank = "A"
		elif Global.GameManager.sessionScore> 40000 and Global.GameManager.sessionScore<=50000:
				sessionrank = "S"
		elif Global.GameManager.sessionScore> 50000 and Global.GameManager.sessionScore<=100000:
				sessionrank = "SS"
		elif Global.GameManager.sessionScore> 50000 and Global.GameManager.sessionScore<=100000:
				sessionrank = "SSS"
		elif Global.GameManager.sessionScore >100000:
				sessionrank = "SSSPLUSMEGAEXTREME"
		
		# set hirank
		if Global.GameManager.sessionScore > Global.GameManager.highScore:
			Global.GameManager.highRank = sessionrank
			Global.GameManager.highScore = Global.GameManager.sessionScore
			if Global.GameManager.sessionMult > Global.GameManager.highMult: Global.GameManager.highMult = Global.GameManager.sessionMult
		
		if Global.GameManager.sessionwords > Global.GameManager.highwords: Global.GameManager.highwords =  Global.GameManager.sessionwords
		
			

func _ready():
	GetRank()
	#session totals
	$HBoxContainer/MarginContainer3/VBoxContainer/SessionWordsContainer/Total/Label.text = str(Global.GameManager.sessionwords)
	$HBoxContainer/MarginContainer3/VBoxContainer/SessionScoreContainer/Total/Label.text = str(Global.GameManager.sessionScore)
	$HBoxContainer/MarginContainer3/VBoxContainer/SessionMultContainer/Total/Label.text = str(Global.GameManager.sessionMult)
	$HBoxContainer/MarginContainer3/VBoxContainer/SessionRankContainer/Total/Label.text = str(sessionrank)

	#High Scores totals
	$HBoxContainer/MarginContainer3/VBoxContainer/HiWordsContainer/Total/Label.text = str(Global.GameManager.highwords)
	$HBoxContainer/MarginContainer3/VBoxContainer/HiScoreContainer/Total/Label.text = str(Global.GameManager.highScore)
	$HBoxContainer/MarginContainer3/VBoxContainer/HiMultContainer/Total/Label.text = str(Global.GameManager.highMult)
	$HBoxContainer/MarginContainer3/VBoxContainer/SessionRankContainer2/Total/Label.text = str(Global.GameManager.highRank)
	
	$AudioStreamPlayer.play()
	
func Restart_on_button_pressed():
	Global.GameManager.Change3D("res://Game Scenes/Gameplay/Gameplay.tscn")
	Global.GameManager.ChangeGUI("res://Game Scenes/Gameplay/score_gui.tscn")

func Menu():
	Global.GameManager.Change3D("res://Game Scenes/LoseScene/StartBG.tscn")
	Global.GameManager.ChangeGUI("res://Game Scenes/Menu.tscn")


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
