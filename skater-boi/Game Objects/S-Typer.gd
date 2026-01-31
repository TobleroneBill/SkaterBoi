extends Sprite3D

@onready var basetext = $"SubViewport/Control/PanelContainer/Base Text"
@onready var usertext = $"SubViewport/Control/PanelContainer/User Text"

# Set the new string to type out
func Update(bg,fg=""):
	#print('input Text:' + fg)
	basetext.text = bg
	usertext.text = fg
