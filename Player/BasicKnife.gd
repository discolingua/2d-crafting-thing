extends Area2D

export var hitStrength = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BasicKnife_body_entered(body):
	print("hit tree")
	body.hitPoints -= hitStrength
	if body.hitPoints <= 0:
		body.queue_free()
	queue_free()
	pass # Replace with function body.
