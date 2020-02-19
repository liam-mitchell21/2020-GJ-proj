extends RigidBody2D


# Declare member variables here. Examples:
export var min_speed = 300
export var max_speed = 450
var ped_types = ["fast", "med", "slow"]


# Called when the node enters the scene tree for the first time.
func _ready():
		$AnimatedSprite.animation = ped_types[randi() % ped_types.size()]

func _on_Area2D_area_entered(area):
	#print(area.get_name())
	if area.get_name() == "PedOut":
		queue_free()


func _on_Peds_body_entered(body):
	if "Player" in body.get_name():
		$Angry.visible = true


func _on_Peds_body_exited(body):
	if "Player" in body.get_name():
		$Angry.visible = false
