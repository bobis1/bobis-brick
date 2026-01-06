extends Node
var threshold
@export var Platforms: Array[PackedScene] = []
var rng = RandomNumberGenerator.new()
var Target_Pose: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	threshold = 10
	Target_Pose.x = 8
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.EnemiesKilled == threshold:
		Globals.PlatformAmount += 1
		var nextPlatform = Platforms[rng.randf_range(0, Platforms.size())].instantiate()
		add_child(nextPlatform)
		Target_Pose.y = -1712.0 * Globals.PlatformAmount
		nextPlatform.global_position = Target_Pose
	pass
