extends Sprite3D

@onready var basetext = $"SubViewport/Control/PanelContainer/PanelContainer/Base Text"
@onready var usertext = $"SubViewport/Control/PanelContainer/PanelContainer/User Text"
@onready var percentageTime = $SubViewport/Control/PanelContainer/ProgressBar


# Set the new string to type out
func Update(bg,fg=""):
	#print('input Text:' + fg)
	basetext.text = bg
	usertext.text = fg

func setProgress(percentage):
	#print(percentage)
	percentageTime.value = percentage

# Animation Functions
func Fadeout():
	$AnimationPlayer.play("HideTyper")

func reset():
	$AnimationPlayer.play("Show Typer")
