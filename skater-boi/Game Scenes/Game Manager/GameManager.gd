class_name GameManager extends Node

@export var world3d: Node3D
@export var world2d: Node2D
@export var GUI: Control

var current3d
var current2d
var currentgui

# Word list
var wordlist = load("res://Scripts/WordLists/words.tres")

func _ready():
	Global.GameManager = self
	Change3D("res://Game Scenes/Gameplay.tscn")
	ChangeGUI("res://Game Scenes/score_gui.tscn")
	
	print(wordlist.easy)
	print(wordlist.medium)
	print(wordlist.hard)
	print(wordlist.extreme)
	
	
# Load 3D Level Scene
func Change3D(NewScene: String) -> void:
	remove_child(current3d)
	var new = load(NewScene).instantiate()
	world3d.add_child(new)
	current3d = new

# Load 2D Level Scene
func Change2D(NewScene: String) -> void:
	remove_child(current2d)
	var new = load(NewScene).instantiate()
	world2d.add_child(new)
	current2d = new

# Load GUI Scene
func ChangeGUI(NewScene: String) -> void:
	if GUI.get_child_count()>0:
		remove_child(currentgui)
	var new = load(NewScene).instantiate()
	GUI.add_child(new)
	currentgui = new
