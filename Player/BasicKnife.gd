class_name BasicKnife
extends Area2D

export var hitStrength : int = 5
var frames : int = 20

func _process(_delta) -> void:
	frames -= 1
	if frames  < 0:
		queue_free()


# this can be set to different item types by setting the collision layer masks
func _on_BasicKnife_body_entered(body) -> void:
	print(hitStrength)
	body.hitPoints -= hitStrength
	if body.hitPoints <= 0:
		body.queue_free()
