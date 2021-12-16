extends KinematicBody2D

const ACCELERATION = 240
const MAX_SPEED = 90
const FRICTION = 600
const GRAVITY = 40
const LIMIT_SPEED_Y = 100
const JUMP_SPEED = 1000

var velocity = Vector2.ZERO


# delta is normally 1/60 (.0166667) at 60FPS
# removing delta slows gameplay with frame drop (might be good?) but
# completely changes the accelation / speed scale

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_Z:
			velocity.y -= JUMP_SPEED    

func _physics_process(delta):

	if velocity.y < LIMIT_SPEED_Y:
		velocity.y += GRAVITY
		
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

		
