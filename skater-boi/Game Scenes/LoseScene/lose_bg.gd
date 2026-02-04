extends Node3D

func _ready():
	$Marker3D/Camera3D/AnimationPlayer.play("Startup")

func _on_animation_player_animation_finished(anim_name):
	$Marker3D/Camera3D/AnimationPlayer.play("CamMove")
