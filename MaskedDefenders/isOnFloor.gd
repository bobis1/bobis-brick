extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load("res://Globals.gd")
	pass # Replace with function body.


func _on_body_entered(body: RigidBody2D) -> void:
	Globals.isOnFloor = true
	print(Globals.isOnFloor)
	pass	

func _on_body_exit(body: RigidBody2D) -> void:
	Globals.isOnFloor = false
	print(Globals.isOnFloor)
	pass
