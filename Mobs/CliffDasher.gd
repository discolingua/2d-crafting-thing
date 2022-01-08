class_name CliffDasher
extends KinematicBody2D
# mobs what are cliff dwelling terries that race towards the player

const GLIDE_SPEED = 120
const DIVE_SPEED = 180

var velocity : Vector2 = Vector2(30,0)
var isDiving : bool = false


func _process(delta):
	position += velocity * delta


func _on_SeekRadius_body_entered(_body:KinematicBody2D) -> void:
		WorldAudio.play("res://Sound/CliffDasher2.wav")
		# velocity = velocity.move_toward(body.position, DIVE_SPEED)
