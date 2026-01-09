extends Node

var time: int = 1000
@export var enemyScene: Array[PackedScene]
var rng = RandomNumberGenerator.new()
@export var spawnPointLeft: Marker2D
@export var spawnPointRight: Marker2D
@export var baseEnemyWaveAmount: int
var spawnPoints: Array[Node]
var enemyWaveAmount: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.PlatformAmount = 1
	enemyWaveAmount = 10
	spawn_wave()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Globals.enemiesKilledInWave == enemyWaveAmount):
		print("next wave starting")
		Globals.enemiesKilledInWave = 0
		await wait(20.0)
		enemyWaveAmount = baseEnemyWaveAmount * Globals.PlatformAmount
		spawn_wave()
		
	pass
func spawn_wave():
	for i in range(enemyWaveAmount):
		await wait(0.5)
		spawnPoints = get_tree().get_nodes_in_group("EnemySpawn")
		var enemySpawned = enemyScene[rng.randi_range(0, enemyScene.size()-1)].instantiate()
		spawnPoints[rng.randi_range(0, spawnPoints.size()-1)].add_child(enemySpawned)
	pass
	
func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
