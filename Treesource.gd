class_name Treesource
extends StaticBody2D

export var hitPoints : int = 10

onready var worldNode =  get_node("/root/World")

func _exit_tree():
	worldNode.invWood += 1
