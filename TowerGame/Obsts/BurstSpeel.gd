extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await wait(0.75)
	queue_free()
	pass # Replace with function body.


func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
