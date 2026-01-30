class_name GameManager extends Node

@export var world3d: Node3D
@export var world2d: Node2D
@export var GUI: Control

var current3d
var current2d
var currentgui

func _ready():
	Global.GameManager = self
	
# Load New Scene
func Change3D(NewScene: String) -> void:
	var new = load(NewScene).instantiate()
	world3d.add_child(new)
	current3d = new

# Load New Scene
func Change2D(NewScene: String) -> void:
	var new = load(NewScene).instantiate()
	world2d.add_child(new)
	current2d = new

# Load New Scene
func ChangeGUI():
	pass
