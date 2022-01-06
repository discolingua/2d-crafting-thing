class_name CliffDasher
extends KinematicBody2D
# mobs what are cliff dwelling terries that race towards the player

const GLIDE_SPEED = 120
const DIVE_SPEED = 180

var velocity : Vector2 = Vector2.ZERO
var isDiving : bool = false
var target = Player

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.RIGHT


func on_SeekBox_body_entered(body: CollisionObject2D) -> void:
	if body.get_name() != self.get_name() and !isDiving:
		var _direction = ai_get_direction()
		var _motion = _direction.normalized() * DIVE_SPEED
		move_and_slide(_motion)



func ai_get_direction():
	return target.position - self.position
