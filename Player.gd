extends KinematicBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

enum STATES {IDLE, WALKING, POWERING, ATTACKING}

var BasicKnife = preload("res://Player/BasicKnife.tscn")

var velocity = Vector2.ZERO
var state = STATES.IDLE


func _physics_process(delta):
	match state:
		STATES.IDLE: idle()
		STATES.ATTACKING: attack()
		STATES.WALKING: walking(delta)
		STATES.POWERING: powerup()
			
	# input vector


	# move_and_slide already has delta factored in from the physics engine
	velocity = move_and_slide(velocity)

#	if Input.is_action_just_released("ui_accept"):
#		var _knife = BasicKnife.instance()
#		_knife.position = Vector2(self.x + 16, self.y)
#		add_child(_knife)
#		print("donk")	

func readMovement():
	var _i = Vector2.ZERO
	
	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	# normalize vector fixes fast/distorted diagonals
	_i = _i.normalized()
	return _i

func walking(delta):
	var _i = readMovement()
	if _i != Vector2.ZERO:	
		velocity = velocity.move_toward(_i * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = STATES.IDLE
	pass

func idle():
	var _i = readMovement()
	if _i != Vector2.ZERO:
		state = STATES.WALKING
	pass
	
func powerup():
	pass
	
func attack():
	pass
