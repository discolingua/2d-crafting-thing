class_name Player
extends KinematicBody2D

# physics engine
const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

# initialize state machine
enum STATES {IDLE, WALKING, POWERING, ATTACKING}
var state : int = STATES.IDLE

# reference to tool objects
var BasicKnife = preload("res://Player/BasicKnife.tscn")

var velocity = Vector2.ZERO

# store most recent non-zero movement input for setting attack direction
var lastVelocity = Vector2.ZERO



# reference to HUD components
onready var powerUpGauge = get_tree().get_root().find_node("PowerUpBar", true, false)
var powerUpLevel : float = 0.0 
var powerUpRate : float = 1.5


func _physics_process(delta) -> void:
	match state:
		STATES.IDLE: idle(delta)
		STATES.ATTACKING: attack(delta)
		STATES.WALKING: walking(delta)
		STATES.POWERING: powerup(delta)
		
	# move_and_slide already has delta factored in from the physics engine
	velocity = move_and_slide(velocity)


func readMovement() -> Vector2:
	var _i = Vector2.ZERO
	
	_i.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_i.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	# normalize vector fixes fast/distorted diagonals
	_i = _i.normalized()
	return _i

func walking(delta) -> void:
	var _i = readMovement()
	if _i != Vector2.ZERO:	
		lastVelocity = _i
		velocity = velocity.move_toward(_i * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = STATES.IDLE

func idle(delta) -> void:
	var _i = readMovement()
	if _i != Vector2.ZERO:
		state = STATES.WALKING
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("ui_accept"):
		state = STATES.POWERING
	pass
	
func powerup(_delta) -> void:
	
	if powerUpLevel <= 100:
		powerUpLevel += powerUpRate
		
	powerUpGauge.value = powerUpLevel
	
	if Input.is_action_just_released("ui_accept"):
		state=STATES.ATTACKING
		powerUpGauge.value = 0.0
	pass
	
func attack(_delta) -> void:
	var _attack = BasicKnife.instance()
	_attack.position = get_parent().position
	_attack.hitStrength = (powerUpLevel * _attack.hitStrength) / 100 
	_attack.rotation = lastVelocity.angle()
	add_child(_attack)
	powerUpLevel = 0
	print("donk")
	state = STATES.IDLE	
