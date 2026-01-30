class_name GameManager extends Node

@export var world3d: Node3D
@export var world2d: Node2D
@export var GUI: Control

var current3d
var current2d
var currentgui

func _ready():
	Global.GameManager = self
	Change2D("res://Game Scenes/test_level_switch.tscn")
	
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
	remove_child(currentgui)
	var new = load(NewScene).instantiate()
	currentgui.add_child(new)
	currentgui = new
