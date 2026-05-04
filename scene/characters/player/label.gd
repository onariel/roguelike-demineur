extends Label
@onready var recovery_time: Timer = $"../Recovery_time"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(recovery_time.time_left)
