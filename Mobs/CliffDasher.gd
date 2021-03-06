class_name CliffDasher
extends KinematicBody2D
# flying mobs that race towards the player

const GLIDE_SPEED = 30
const DIVE_SPEED = 50

var velocity : Vector2 = Vector2(GLIDE_SPEED,0)
var isDiving : bool = false

onready var playerNode = get_node("/root/World/YSort/Player")


func _physics_process(_delta) -> void:
	velocity = move_and_slide(velocity)


func _on_SeekRadius_body_entered(_body:KinematicBody2D) -> void:
		if (_body == playerNode) and (!isDiving ):
			# WorldAudio.play("res://Sound/CliffDasher2.wav")
			velocity = self.position.direction_to(_body.position) * DIVE_SPEED
			isDiving = true


# Called by CleanupTimer to garbage collect OOB creatures			
func checkBounds() -> void:
	if (self.global_position.x < -100) or (self.global_position.x > 200):
		queue_free()