extends KinematicBody2D

const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

enum STATES {IDLE, WALKING, POWERING, ATTACKING}

var BasicKnife = preload("res://Player/BasicKnife.tscn")

var velocity = Vector2.ZERO

var powerUpLevel = 0.0
var powerUpRate = 1.5

# reference to HUD components
onready var powerUpGauge = get_tree().get_root().find_node("PowerUpBar", true, false)

# default state for state machine
var state = STATES.IDLE

func _physics_process(delta):
	match state:
		STATES.IDLE: idle(delta)
		STATES.ATTACKING: attack(delta)
		STATES.WALKING: walking(delta)
		STATES.POWERING: powerup(delta)
		
	# move_and_slide already has delta factored in from the physics engine
	velocity = move_and_slide(velocity)


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

func idle(delta):
	var _i = readMovement()
	if _i != Vector2.ZERO:
		state = STATES.WALKING
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("ui_accept"):
		state = STATES.POWERING
	pass
	
func powerup(_delta):
	
	if powerUpLevel <= 100:
		powerUpLevel += powerUpRate
		
	powerUpGauge.value = powerUpLevel
	
	if Input.is_action_just_released("ui_accept"):
		state=STATES.ATTACKING
		powerUpGauge.value = 0.0
	pass
	
func attack(_delta):
	var _knife = BasicKnife.instance()
	_knife.position = get_parent().position
	_knife.position.x += 8
	_knife.hitStrength = (powerUpLevel * _knife.hitStrength) / 100 
	add_child(_knife)
	powerUpLevel = 0
	print("donk")
	state = STATES.IDLE	
	pass
