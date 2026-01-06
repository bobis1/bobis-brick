extends Node

var time: int = 100
var enemyScene: PackedScene = preload("res://Obsts/Enemy.tscn")
@export var spawnPointLeft: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= 1
	if time <= 0:
		var enemySpawned = enemyScene.instantiate()
		spawnPointLeft.add_child(enemySpawned)
		time = 100
	print(time)
		
		
		
		
		
	pass
