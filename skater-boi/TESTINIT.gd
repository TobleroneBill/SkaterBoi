extends Node3D



func printtest():
	print('hi')

func _ready():
	$CSGCylinder3D/AnimationPlayer.play("Rotate")
	printtest()


func _on_animation_player_animation_finished(anim_name):
	$CSGCylinder3D/AnimationPlayer.play("Rotate")
