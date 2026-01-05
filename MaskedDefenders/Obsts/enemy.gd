extends RigidBody2D

@export var linear_force: float = 5.0
@export var target: Marker2D
@export var health: float

var targetPose: Vector2

func _ready() -> void:
	if target:
		targetPose = target.global_position
	health = 100

func _physics_process(delta: float) -> void:
	if not target:
		return

	targetPose = target.global_position

	var direction = (targetPose - global_position).normalized()
	var distance = global_position.distance_to(targetPose)

	constant_force = direction * linear_force * distance
	if health <= 0:
		queue_free()
	

func _on_body_entered(body: Node2D):
	if(body.is_in_group("Projectile")):
		health -= 10
		print(health)
		body.queue_free()
	if(body.is_in_group("Player")):
		Globals.Health -= 10
		print(Globals.Health)
		
		if Globals.isLeft == Vector2.RIGHT:
			linear_velocity.x = 1200
			body.global_position.y += -10
			body.global_position.x += -50
		elif Globals.isLeft == Vector2.LEFT:
			linear_velocity.x = -1200
			body.global_position.y += -10
			body.global_position.x += 50
	pass
	
