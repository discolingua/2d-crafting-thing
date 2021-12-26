extends Camera2D

func _process(delta):
	global_position = posY
	global_position.x = player.global_position.x
