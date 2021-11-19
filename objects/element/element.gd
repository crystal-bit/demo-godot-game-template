extends Sprite
tool
class_name Element

var state = 'idle'
var colors = ["red", "blue", "green"]

export(String) var element_color = "red" setget set_element_color


func set_element_color(val: String):
	var texture_path = "res://assets/puzzle/element_%s_square.png" % val
	var f = File.new()
	if f.file_exists(texture_path):
		texture = load(texture_path)
	else:
		texture = null


func size() -> Vector2:
	return texture.get_size() * scale


func set_random_color():
	self.element_color = colors[rand_range(0, colors.size())]


func on_pressed(ev: InputEventMouseButton):
	state = "grabbed"


func on_released(ev: InputEventMouseButton):
	state = "idle"


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var shape: RectangleShape2D = $Area2D/CollisionShape2D.shape
			var shape_size = shape.extents * scale
			var rect = Rect2($Area2D.global_position - shape_size, shape_size * 2)
			if rect.has_point(event.position):
				get_tree().set_input_as_handled()
				on_pressed(event)
		else:
			if state == "grabbed":
				on_released(event)
				get_tree().set_input_as_handled()

	if event is InputEventMouseMotion:
		if state == "grabbed":
			global_position = event.position
			get_tree().set_input_as_handled()
