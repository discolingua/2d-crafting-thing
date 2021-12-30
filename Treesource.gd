class_name Treesource
extends StaticBody2D

export var hitPoints : int = 10

onready var worldNode =  get_node("/root/World")

func _exit_tree():
	print("tree blep")
	worldNode.invWood += 1
	# add 1 to the inventory
