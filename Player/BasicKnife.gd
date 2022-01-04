class_name BasicKnife
extends Area2D
# the basic wood chopping tool

# cast hitStrength as float because it gets
# multiplied by a percentage 
export(float) var hitStrength : float = 4.0

var frames : int = 20


func _process(_delta) -> void:
	frames -= 1
	if frames < 0:
		queue_free()


# this can be set to different item types by setting the collision layer masks
func _on_BasicKnife_body_entered(body: CollisionObject2D) -> void:
	print(hitStrength)
	body.hitPoints -= hitStrength
	WorldAudio.play("res://Sound/axeChop.wav")
	if body.hitPoints <= 0:
		body.queue_free()
