extends Control

func Start_on_button_pressed():
	Global.GameManager.Change3D("res://Game Scenes/Gameplay/Gameplay.tscn")
	Global.GameManager.ChangeGUI("res://Game Scenes/Gameplay/score_gui.tscn")

func Credits_on_button_pressed():
	Global.GameManager.ChangeGUI("res://Game Scenes/Credits/credits.tscn")


func _on_mainmenu_finished():
	$Mainmenu.play()
