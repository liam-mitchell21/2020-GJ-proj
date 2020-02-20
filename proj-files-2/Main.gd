extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	$Player.start($StartPosition.position)
	
	$HUD/PHONE/latestMessage.text = "or your boss might not be happy"
	$HUD/PHONE/secondMessage.text = "try your best to be on-time"
	$HUD/PHONE/thirdMessage.text = "Hello, and welcome"
	$HUD/PHONE/msg.text = "TIME UNTIL WORK:"
	$HUD/PHONE/Label.text = "NEW NOTIFICATION!"
	

func _on_HUD_ded():
	$HUD/StartButton.visible = true
	
func _on_Player_crash():
	$HUD/StartButton.visible = true

func _on_Player_win():
	$HUD/StartButton/Label.text = "Right, you got to work on time. Good Job?"
	$HUD/StartButton.visible = true
