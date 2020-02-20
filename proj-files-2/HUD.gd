extends CanvasLayer

signal start_game
signal filestuff
signal ded

func _ready():
	emit_signal("filestuff")

func _process(_delta):
	$PHONE/time.text = str($time2work.time_left)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	$PHONE/MessageTimer.start()
	$time2work.start()
	$PHONE/time.text = str($time2work.time_left)

func show_game_over():
	$PHONE/MessageTimer.stop()
	
	var losstext = "LOSE"

	$PHONE/latestMessage.text = losstext
	$PHONE/secondMessage.text = losstext
	$PHONE/thirdMessage.text = losstext
	$PHONE/Label.text = losstext

	$Borrowedtime.start()


func _on_Borrowedtime_timeout():
	emit_signal("ded")

func new_message(text, r1, r2, r3): #eugh duplicating the func
	$PHONE/Notification.play()
	$PHONE/thirdMessage.text = $PHONE/secondMessage.text
	$PHONE/secondMessage.text = $PHONE/latestMessage.text
	
	$PHONE/latestMessage.text = text
	
	$PHONE/Reply.text = r1
	$PHONE/Reply.show()
	$PHONE/Reply2.text = r2
	$PHONE/Reply2.show()
	$PHONE/Reply3.text = r3
	$PHONE/Reply3.show()

func _on_DirectionTrigger1_area_entered(area):
	if (area.get_name() == "Phitbox"):
		$PHONE/MessageTimer.start()
		new_message("GO SOUTH", "Who are you", "Why", "OK")

func _on_DirectionTrigger2_area_entered(area):
	if (area.get_name() == "Phitbox"):
		$PHONE/MessageTimer.start()
		new_message("GO EAST", "How did you get this #", "...", "OK")

func _on_DirectionTrigger3_area_entered(area):
	if (area.get_name() == "Phitbox"):
		$PHONE/MessageTimer.start()
		new_message("GO NORTH", "...", "...", "OK")
