class_name CliffDasher
extends KinematicBody2D
# mobs what are cliff dwelling terries that race towards the player

const GLIDE_SPEED = 120
const DIVE_SPEED = 180

var velocity : Vector2 = Vector2.ZERO
var isDiving : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.RIGHT



func ai_get_direction():
	# return target.position - self.position
	pass


func _on_SeekRadius_body_entered(body:KinematicBody2D) -> void:
	print(body)
	print("dodongo")
	pass # Replace with function body.
