extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700.0

var leftProjectileScene: PackedScene = preload("res://Obsts/projectileLeft.tscn")
var rightProjectileScene: PackedScene = preload("res://Obsts/projectileRight.tscn")

@export var spawnOffset: Vector2
@export var leftShoot: Marker2D
@export var rightShoot: Marker2D


func _ready() -> void:
	Globals.Health = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle shooting
	if Input.is_action_just_pressed("ShootLeft"):
		var projectileLeft = leftProjectileScene.instantiate()
		add_child(projectileLeft)
		#projectileLeft.position = leftShoot.global_position
	if Input.is_action_just_pressed("ShootRight"):
		var projectile = rightProjectileScene.instantiate()
		add_child(projectile)
		#projectile.position = rightShoot.global_position
	
	if Globals.Health <= 0:
		queue_free()
		
	if Input.is_action_pressed("MOVE_LEFT"):
		Globals.isLeft = Vector2.LEFT
	if Input.is_action_pressed("MOVE_RIGHT"):
		Globals.isLeft = Vector2.RIGHT
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("MOVE_LEFT", "MOVE_RIGHT")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
