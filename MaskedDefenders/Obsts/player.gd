extends RigidBody2D
@export var speedFactor: float
@export var player: RigidBody2D
var isGrounded: bool

# var gravity = 9.8



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speedFactor = 1
	isGrounded = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("MOVE_LEFT")):
		linear_velocity.x = -400
		#position += Vector2(-10 * speedFactor, 0)
	if(Input.is_action_pressed("MOVE_RIGHT")):
		#position += Vector2(10 * speedFactor, 0)
		linear_velocity.x = 400
	if(Input.is_action_just_pressed("JUMP")):
		if(isGrounded):
			linear_velocity.y = -400
	pass

func _on_body_entered(body):
	isGrounded = true
	pass
func _on_body_exit(body):
	isGrounded = false
	pass
