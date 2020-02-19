extends CanvasLayer

signal replied
signal start_game

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func show_message(text):
	$secondMessage.text = $latestMessage.text
	$secondMessage.show()
	
	$latestMessage.text = text
	$latestMessage.show()
	
	$Reply.text = "YES!"
	$Reply.show()
	
	$time2work.start

func show_game_over():
	show_message("You Lose")

	yield($time2work, "timeout")

	$secondMessage.text = "TRY AGAIN"
	$secondMessage.show()
	
	$latestMessage.text = "TRY AGAIN"
	$latestMessage.show()
	
	$Reply3.text = "BEGIN"
	$Reply3.show()

	yield(get_tree().create_timer(1), "timeout")

func _on_Reply_pressed():
	emit_signal("replied")
func _on_Reply2_pressed():
	emit_signal("replied")
func _on_Reply3_pressed():
	emit_signal("replied")

func _on_MessageTimer_timeout():
	## WHERE WE GET NEW MSG
	show_message("newtext")
