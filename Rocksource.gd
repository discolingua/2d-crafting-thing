class_name Rocksource
extends StaticBody2D

export(int) var hitPoints : int = 10

onready var worldNode =  get_node("/root/World")

func _exit_tree():
	WorldAudio.play("res://Sound/treeFall.wav")
	worldNode.invStone += 1
