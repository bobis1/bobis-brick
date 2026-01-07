extends Node

var time: int = 1000
@export var enemyScene: Array[PackedScene]
var rng = RandomNumberGenerator.new()
@export var spawnPointLeft: Marker2D
@export var spawnPointRight: Marker2D
var spawnPoints: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawnPoints = get_tree().get_nodes_in_group("EnemySpawn")
	time -= 1
	if time <= 0:
		time = 100
		var enemySpawned = enemyScene[rng.randf_range(0, enemyScene.size())].instantiate()
		spawnPoints[rng.randi_range(0, spawnPoints.size()-1)].add_child(enemySpawned)
		#if rng.randi_range(0, 1) == 0:
		#	spawnPointLeft.add_child(enemySpawned)
		#else:
		#	spawnPointRight.add_child(enemySpawned)
		
		
		
		
		
	pass
