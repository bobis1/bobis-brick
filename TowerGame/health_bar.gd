extends ProgressBar

func _ready():
	max_value = 1000
	value = Globals.Health

func _process(delta):
	value = Globals.Health * 1000/ max_value
