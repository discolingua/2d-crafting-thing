class_name Player
extends KinematicBody2D
# the main player character and tool spawner

# initialize state machine
enum STATES {IDLE, WALKING, POWERING, ATTACKING}

# physics engine
const ACCELERATION = 600
const MAX_SPEED = 100
const FRICTION = 800

var currentToolNumber: int = 0 setget set_currentToolNumber
var toolImages = ["res://pixelsword.png", "res://pixelPick.png"]
var toolDisplay = NodePath("/root/HUD_GUI/ActiveToolDisplay:texture")
var state : int = STATES.IDLE
var BasicKnife = preload("res://Player/BasicKnife.tscn")
var PickAxe = preload("res://Player/PickAxe.tscn")
var playerTools = [BasicKnife, PickAxe]

# store most recent non-zero movement input for setting attack direction
var velocity = Vector2.ZERO
var lastVelocity = Vector2.ZERO

# reference to HUD components
var powerUpLevel : float = 0.0 
var powerUpRate : float = 1.5


onready var powerUpGauge = get_node("/root/World/HUD_GUI/PowerUpBar")



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
		
	# Q & E or bumpers cycle active tool
	if Input.is_action_just_pressed("ui_focus_next"):
		self.currentToolNumber += 1
	if Input.is_action_just_pressed("ui_focus_prev"):
		self.currentToolNumber -= 1
		
 
	
func powerup(_delta) -> void:
	# the powerup state allows user to hold a button to fill the powerUpGauge,
	# which provides a percentage of full damage for tht hit
	if powerUpLevel <= 100:
		powerUpLevel += powerUpRate
		
	powerUpGauge.value = powerUpLevel
	
	if Input.is_action_just_released("ui_accept"):
		state=STATES.ATTACKING
		powerUpGauge.value = 0.0

	
func attack(_delta) -> void:
	var _toolInstance = playerTools[currentToolNumber].instance()
	_toolInstance.position = get_parent().position
	_toolInstance.hitStrength = (powerUpLevel * _toolInstance.hitStrength) / 100 
	_toolInstance.rotation = lastVelocity.angle()
	add_child(_toolInstance)
	powerUpLevel = 0
	state = STATES.IDLE	

func set_currentToolNumber(value:int):
	if value != currentToolNumber:
		if value > playerTools.size() - 1:
			currentToolNumber = 0
		elif value < 0:
			currentToolNumber = playerTools.size() - 1
		else:
			currentToolNumber = value
		print(currentToolNumber)
		toolDisplay = toolImages[currentToolNumber]
