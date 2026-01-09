extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1200.0

var leftProjectileScene: PackedScene = preload("res://Obsts/projectileLeft.tscn")
var rightProjectileScene: PackedScene = preload("res://Obsts/projectileRight.tscn")
var upProjectileScene: PackedScene = preload("res://Obsts/projectileUp.tscn")
var downProjectileScene: PackedScene = preload("res://Obsts/projectileDown.tscn")
@export var maxClipSize: int
var currentClip: int

@export var spawnOffset: Vector2
@export var leftShoot: Marker2D
@export var rightShoot: Marker2D
@export var ammoCounters: Array[Sprite2D]
@export var log: RigidBody2D


func _ready() -> void:
	Globals.Health = 1000
	currentClip = maxClipSize

func _physics_process(delta: float) -> void:
	match currentClip:
				0:
					ammoCounters[0].visible = false
				1:
					ammoCounters[1].visible = false
				2:
					ammoCounters[2].visible = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle shooting
	if Input.is_action_just_pressed("Shoot"):
		if currentClip > 0:
			var projectile = leftProjectileScene.instantiate()
			add_child(projectile)
			currentClip -= 1
			
			
	if Input.is_action_just_pressed("Reload"):
		await wait(2.0)
		currentClip = maxClipSize
		var index = 0
		for i in range(ammoCounters.size()):
			ammoCounters[index].visible = true
			index += 1
	
	if Globals.Health <= 0:
		get_tree().change_scene_to_file("res://main.tscn")
		log.global_position = Vector2(133, -1726)

		
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
	
func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
