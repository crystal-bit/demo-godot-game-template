extends ColorRect

func _ready():
	rect_position = OS.get_window_safe_area().position
	rect_size = OS.get_window_safe_area().size
