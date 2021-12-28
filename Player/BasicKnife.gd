extends Area2D

export var hitStrength = 5
var frames = 20

func _process(delta) -> void:
	frames -= 1
	if frames  < 0:
		queue_free()


func _on_BasicKnife_body_entered(body) -> void:
	print(hitStrength)
	body.hitPoints -= hitStrength
	if body.hitPoints <= 0:
		body.queue_free()
