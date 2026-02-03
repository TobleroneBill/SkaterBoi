extends Sprite3D

#@onready var basetext = $"SubViewport/Control/PanelContainer/PanelContainer/Base Text"
#@onready var usertext = $"SubViewport/Control/PanelContainer/PanelContainer/User Text"
#@onready var percentageTime = $SubViewport/Control/PanelContainer/ProgressBar

@onready var basetext = $"SubViewport/Control/PanelContainer/MarginContainer/Base Text"
@onready var usertext = $"SubViewport/Control/PanelContainer/MarginContainer/User Text"
@onready var percentageTime = $SubViewport/Control/PanelContainer/ProgressBar

# Set the new string to type out
func Update(bg,fg=""):
	basetext.text = bg
	usertext.text = fg

func setProgress(percentage):
	percentageTime.value = percentage

# Animation Functions
func Fadeout():
	$AnimationPlayer.play("HideTyper")

func reset():
	$AnimationPlayer.play("Show Typer")
