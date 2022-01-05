class_name Rocksource
extends StaticBody2D

export(int) var hitPoints : int = 10

var Cave = preload("res://CaveEntry.tscn")

onready var worldNode =  get_node("/root/World")

func _exit_tree():
	WorldAudio.play("res://Sound/rockBreak.wav")
	worldNode.invStone += 1
	if randi() % 3 == 0:
		var _cave = Cave.instance()
		_cave.position = self.position
		get_node("/root/World/TileMap").add_child(_cave)
		print("cave")
