extends Sprite3D

# Set the new string to type out
func SetText():
	pass
	
# Update the User Text
func UpdateUI(userText):
	$"SubViewport/Control/PanelContainer/User Text".text = userText
