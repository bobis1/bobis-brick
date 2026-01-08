extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_body_entered(body: Node) -> void:
	if (body.is_in_group("Player")):
		Globals.Health -= 100
		#Add a shader to make the flag darker for the cooldown
		#await get_tree().create_timer(2).timeout
		
		
	pass # Replace with function body.
