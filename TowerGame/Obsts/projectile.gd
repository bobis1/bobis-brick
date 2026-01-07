extends RigidBody2D
@export var linear_force: float = 15.0

@export var health: float

var targetPose: Vector2

var direction
var distance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetPose = get_global_mouse_position()
	direction = (targetPose - global_position).normalized()
	distance = global_position.distance_to(targetPose)
	look_at(get_global_mouse_position())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	constant_force = direction * linear_force * distance
	pass
	
