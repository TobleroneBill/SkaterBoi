extends Node2D

func _ready():
	print("scene1")
	Global.GameManager.Change3D("res://Game Scenes/cool_scene.tscn")
	
