extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -1200.0

var leftProjectileScene: PackedScene = preload("res://Obsts/projectileLeft.tscn")
var burstScene: PackedScene = preload("res://Obsts/BurstSpell.tscn")
@export var maxClipSize: int
@export var maxBurstClipSize: int
@export var maxSuperJump:int
@export var superJumpFactor: float = 5.0
var currentClip: int
var currentBurst: int
var currentSuperJump: int

@export var spawnOffset: Vector2
@export var ammoCounters: Array[Sprite2D]
@export var burstAmmoCounter: Sprite2D
@export var superJumpCounter: Sprite2D
@export var log: RigidBody2D
@export var PlayerSprite: Sprite2D

var isReloading: bool

func _ready() -> void:
	Globals.Health = 1000
	currentClip = maxClipSize
	currentBurst = maxBurstClipSize
	currentSuperJump = maxSuperJump

func _physics_process(delta: float) -> void:
	if currentClip != 4:
		ammoCounters[currentClip].visible = false
	if Globals.isLeft == Vector2.RIGHT:
		PlayerSprite.scale.x = 0.25
	if Globals.isLeft == Vector2.LEFT:
		PlayerSprite.scale.x = -0.25
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle shooting
	if Input.is_action_just_pressed("Shoot"):
		if currentClip > 0:
			if (!isReloading):
				var projectile = leftProjectileScene.instantiate()
				add_child(projectile)
				currentClip -= 1

	if Input.is_action_just_pressed("Burst"):
		if currentBurst > 0:
			if (!isReloading):
				var burst = burstScene.instantiate()
				add_child(burst)
				burstAmmoCounter.visible = false	
				currentBurst -= 1
	if Input.is_action_just_pressed("SuperJump"):
		if currentSuperJump > 0:
			if (!isReloading):
				velocity.y = JUMP_VELOCITY * superJumpFactor
				currentSuperJump -= 1
				superJumpCounter.visible = false
			
			
	if Input.is_action_just_pressed("Reload"):
		if(!isReloading):
			isReloading = true
			await wait(2.0)
			currentClip = maxClipSize
			currentBurst = maxBurstClipSize
			currentSuperJump = maxSuperJump
			var index = 0
			for i in range(ammoCounters.size()):
				ammoCounters[index].visible = true
				index += 1
			superJumpCounter.visible = true
			burstAmmoCounter.visible = true
			isReloading = false
	
	if Globals.Health <= 0:
		get_tree().change_scene_to_file("res://main.tscn")
		log.global_position = Vector2(133, -1726)
		Globals.EnemiesKilled = 0
		Globals.PlatformAmount = 0
		Globals.waveNumber = 1

		
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
