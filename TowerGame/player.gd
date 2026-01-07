extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -950.0

var leftProjectileScene: PackedScene = preload("res://Obsts/projectileLeft.tscn")
var rightProjectileScene: PackedScene = preload("res://Obsts/projectileRight.tscn")
var upProjectileScene: PackedScene = preload("res://Obsts/projectileUp.tscn")
var downProjectileScene: PackedScene = preload("res://Obsts/projectileDown.tscn")

@export var spawnOffset: Vector2
@export var leftShoot: Marker2D
@export var rightShoot: Marker2D


func _ready() -> void:
	Globals.Health = 1000

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle shooting
	if Input.is_action_just_pressed("ShootLeft"):
		if Globals.isLeft == Vector2.LEFT:
			var projectile = leftProjectileScene.instantiate()
			add_child(projectile)
	
	if Globals.Health <= 0:
		get_tree().change_scene_to_file("res://main.tscn")
		
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
