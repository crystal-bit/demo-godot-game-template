extends Spatial
class_name Spaceship

onready var bullet_scene = preload("res://objects/spaceship/bullet/bullet.tscn")
onready var gameplay = get_node("../../")
onready var camera: Camera = get_node("../Camera")

# input
var current_input = "keyboard"
var last_pointer_pos = Vector2()
var pointer_pressed = false
# movement
var y_speed = 12
var x_speed = 12
# fire
var cooldown = 0.1 # s
var cooldown_timer = 0 # s

signal destroyed


func _process(delta):
	# movement
	var movement = Vector2()
	movement = get_movement(movement)
	movement *= delta

	translation.x += movement.x * x_speed
	translation.x = clamp(translation.x, gameplay.top_left.x, gameplay.bot_right.x)
	translation.y += movement.y * y_speed
	translation.y = clamp(translation.y, gameplay.bot_right.y, gameplay.top_left.y)
	# fire
	if (current_input == "mouse" and pointer_pressed) or (Input.is_action_pressed("fire")):
		if cooldown_timer <= 0:
			fire()
			cooldown_timer = cooldown
		cooldown_timer -= delta


func get_movement(movement: Vector2) -> Vector2:
	movement.x = 0
	movement.y = 0
	if current_input == "keyboard":
		if Input.is_action_pressed("ui_left"):
			movement.x = -1
		if Input.is_action_pressed("ui_right"):
			movement.x = 1
		if Input.is_action_pressed("ui_down"):
			movement.y = -1
		if Input.is_action_pressed("ui_up"):
			movement.y = 1
		return movement.normalized()
	elif current_input == "mouse":
		if pointer_pressed:
			return calculate_point(last_pointer_pos).normalized()
		return Vector2()
	else:
		return Vector2()


func _input(event):
	if event is InputEventKey:
		current_input = "keyboard"
	if event is InputEventMouseButton:
		current_input = "mouse"
		pointer_pressed = event.pressed
	if event is InputEventMouseMotion:
		if pointer_pressed:
			last_pointer_pos = event.position


func calculate_point(p: Vector2) -> Vector2:
	var spaceship_screen_position = camera.unproject_position(self.translation)
	var movement = p - spaceship_screen_position
	if movement.length() < 20:
		return Vector2()
	movement.y = -movement.y
	return movement


func fire():
	var b = bullet_scene.instance()
	b.translation = translation
	b.translation.y += 1
	get_parent().add_child(b)


func _on_Area_area_entered(area):
	if area is Enemy:
		queue_free()
		emit_signal("destroyed")
