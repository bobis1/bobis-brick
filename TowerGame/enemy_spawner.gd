extends Node

var time: int = 1000
@export var enemyScene: Array[PackedScene]
var rng = RandomNumberGenerator.new()
@export var baseEnemyWaveAmount: int
@export var WaveNum: Label
@export var Audio: AudioStreamPlayer2D
var spawnPoints: Array[Node]
var enemyWaveAmount: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.PlatformAmount = 1
	enemyWaveAmount = 10
	Globals.waveNumber = 1
	WaveNum.text = str(Globals.waveNumber)
	spawn_wave()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Globals.enemiesKilledInWave == enemyWaveAmount):
		print("next wave starting")
		Globals.enemiesKilledInWave = 0
		WaveNum.text = str(Globals.waveNumber)
		await wait(15.0)
		Audio.play()
		enemyWaveAmount = baseEnemyWaveAmount * Globals.PlatformAmount
		print("Wave About to start")
		spawn_wave()
		
	pass
func spawn_wave():
	Globals.waveNumber += 1
	for i in range(enemyWaveAmount):
		await wait(0.5)
		spawnPoints = get_tree().get_nodes_in_group("EnemySpawn")
		var enemySpawned = enemyScene[rng.randi_range(0, enemyScene.size()-1)].instantiate()
		spawnPoints[rng.randi_range(0, spawnPoints.size()-1)].add_child(enemySpawned)
		print("enemy spawned")
	pass
	
func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
