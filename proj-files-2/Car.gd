extends RigidBody2D

signal crash

# Declare member variables here. Examples:
export var min_speed = 500
export var max_speed = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_Area2D_area_entered(area):
	#print(area.get_name())
	if "CarOut" in area.get_name():
		queue_free()

func _on_Car_body_entered(body):
	if "Player" in body.get_name():
		if min_speed > 0:
			$Angry.visible = true
			emit_signal("crash")

func _on_Car_body_exited(body):
	if "Player" in body.get_name():
		$Angry.visible = false

