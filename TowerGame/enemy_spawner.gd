extends Node

var time: int = 1000
var enemyScene: PackedScene = preload("res://Obsts/Enemy.tscn")
var rng = RandomNumberGenerator.new()
@export var spawnPointLeft: Marker2D
@export var spawnPointRight: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= 1
	if time <= 0:
		time = 100
		var enemySpawned = enemyScene.instantiate()
		if rng.randi_range(0, 1) == 0:
			spawnPointLeft.add_child(enemySpawned)
		else:
			spawnPointRight.add_child(enemySpawned)
		
		
		
		
		
	pass
