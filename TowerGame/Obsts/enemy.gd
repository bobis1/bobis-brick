extends RigidBody2D

@export var linear_force: float = 5.0
@export var target: Marker2D
@export var burst_knockback_force: float = 2500.0

@export var health: float

var knockbackDir

var targetPose: Vector2

func _ready() -> void:
	if target:
		targetPose = target.global_position
	target = $"/root/Node2D/Player/PlayerMarker"
	

func _physics_process(delta: float) -> void:
	if not target:
		return
	targetPose = target.global_position

	var direction = (targetPose - global_position).normalized()
	var distance = global_position.distance_to(targetPose)

	constant_force = direction * linear_force * distance
	if health <= 0:
		Globals.EnemiesKilled += 1
		Globals.enemiesKilledInWave += 1
		print("EnemiesKilled: ", Globals.EnemiesKilled)
		queue_free()
		

func _on_body_entered(body: Node2D):
	if(body.is_in_group("Projectile")):
		health -= 10		
		body.queue_free()
	if(body.is_in_group("Burst")):
		health -= 10
		knockbackDir = (global_position - body.global_position).normalized()
		apply_impulse(knockbackDir * burst_knockback_force)
		
	if(body.is_in_group("Player")):
		Globals.Health -= 10
		if Globals.isLeft == Vector2.RIGHT:
			linear_velocity.x = 1600
		elif Globals.isLeft == Vector2.LEFT:
			linear_velocity.x = -1600
	if(body.is_in_group("Enemy") && !is_in_group("Flying")):
		linear_velocity.y = -800	
	pass
	
func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout

	
