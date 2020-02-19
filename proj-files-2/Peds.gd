extends RigidBody2D


# Declare member variables here. Examples:
export var min_speed = 150
export var max_speed = 250
var ped_types = ["fast", "med", "slow"]


# Called when the node enters the scene tree for the first time.
func _ready():
		$AnimatedSprite.animation = ped_types[randi() % ped_types.size()]

func _on_Area2D_area_entered(area):
	#print(area.get_name())
	if area.get_name() == "PedOut":
		queue_free()
