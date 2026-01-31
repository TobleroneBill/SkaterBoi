extends Control



func _on_button_pressed():
	Global.GameManager.Change3D("res://Game Scenes/Gameplay.tscn")
	Global.GameManager.ChangeGUI("res://Game Scenes/score_gui.tscn")
	
