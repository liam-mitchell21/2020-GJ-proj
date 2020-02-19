extends CanvasLayer

signal replied1
signal replied2
signal replied3
signal start_game
signal filestuff

func _ready():
	emit_signal("filestuff")

func _process(delta):
	$PHONE/Panel/time.text = str($time2work.time_left)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	$PHONE/MessageTimer.start()
	$time2work.start()
	$PHONE/Panel/time.text = str($time2work.time_left)

func show_game_over():
	yield($time2work, "timeout")

	$secondMessage.text = "TRY AGAIN"
	$secondMessage.show()
	
	$latestMessage.text = "TRY AGAIN"
	$latestMessage.show()
	
	$Reply3.text = "BEGIN"
	$Reply3.show()

	yield(get_tree().create_timer(1), "timeout")

func _on_Reply_pressed():
	emit_signal("replied1")
	$PHONE/Panel2/Count.text = str(int($PHONE/Panel2/Count.text) - 1)
func _on_Reply2_pressed():
	emit_signal("replied2")
	$PHONE/Panel2/Count.text = str(int($PHONE/Panel2/Count.text) - 1)
func _on_Reply3_pressed():
	emit_signal("replied3")
	$PHONE/Panel2/Count.text = str(int($PHONE/Panel2/Count.text) - 1)
