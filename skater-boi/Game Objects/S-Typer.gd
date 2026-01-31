extends Sprite3D

@onready var basetext = $"SubViewport/Control/PanelContainer/PanelContainer/Base Text"
@onready var usertext = $"SubViewport/Control/PanelContainer/PanelContainer/User Text"

# Set the new string to type out
func Update(bg,fg=""):
	#print('input Text:' + fg)
	basetext.text = bg
	usertext.text = fg

# Animation Functions
func Fadeout():
	$AnimationPlayer.play("HideTyper")

func reset():
	$AnimationPlayer.play("Show Typer")
