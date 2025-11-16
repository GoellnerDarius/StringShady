extends Node

@export var time_seconds:float
@export var timer: Timer
@export var timeLeft: ProgressBar
func _ready() -> void:
	timer.one_shot=true
	timer.start(time_seconds)
	timer.timeout.connect(TimeOut)
	timeLeft.show_percentage=false
	timeLeft.min_value=0
	timeLeft.max_value=time_seconds
	timeLeft.value=0
	
	
	
func _process(delta: float) -> void:
	timeLeft.value+=delta
	if timeLeft.value >= 100:
		TimeOut()
	
	
	
	
func TimeOut()->void:
	#Todo put logic in later
	get_tree().quit()
	pass	
