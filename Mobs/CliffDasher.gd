class_name CliffDasher
extends KinematicBody2D
# mobs what are cliff dwelling terries that race towards the player

const GLIDE_SPEED = 120
const DIVE_SPEED = 180

var velocity : Vector2 = Vector2(30,0)
var isDiving : bool = false


func _process(delta):
	position += velocity * delta


func ai_get_direction():
	# return target.position - self.position
	pass


func _on_SeekRadius_body_entered(body:KinematicBody2D) -> void:
	pass # Replace with function body.
