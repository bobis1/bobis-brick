extends Node

var time: int = 10000
var enemyScene: PackedScene = preload("res://Obsts/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= 1
	if time <= 0:
		var enemySpawned = enemyScene.instantiate()
		
		
		
	pass
