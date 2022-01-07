extends Node2D

const CliffDasher = preload("res://Mobs/CliffDasher.tscn")

# number of resources in inventory
export(int) var invWood : int = 0 setget set_invWood
export(int) var invStone : int = 0 setget set_invStone

onready var playerNode = get_node("YSort/Player")

func _ready() -> void:
	randomize()

func set_invWood(value:int):
	if value != invWood:
		invWood = int(clamp(value,0,999))
		$HUD_GUI/CountWood.text = str(invWood).pad_zeros(3)


func set_invStone(value:int):
	if value != invStone:
		invStone = int(clamp(value,0,999))
		$HUD_GUI/CountStone.text = str(invStone).pad_zeros(3)
		


func _on_SpawnTimer_timeout():
	var _playerY = playerNode.position.y
	var _y = _playerY + rand_range(-200,200)
	var _cliffDasher = CliffDasher.instance()
	_cliffDasher.position.x = -50
	_cliffDasher.position.y = _y
	add_child(_cliffDasher)
