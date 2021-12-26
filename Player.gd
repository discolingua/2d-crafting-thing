extends KinematicBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800


var velocity = Vector2.ZERO


	

func _physics_process(delta):
		
	# input vector
	var _i = Vector2.ZERO
	
	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	# normalize vector fixes fast/distorted diagonals
	_i = _i.normalized()

	if _i != Vector2.ZERO:	
		velocity = velocity.move_toward(_i * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# move_and_slide already has delta factored in from the physics engine
	velocity = move_and_slide(velocity)

	if Input.is_action_just_released("ui_accept"):
		print("donk")	
