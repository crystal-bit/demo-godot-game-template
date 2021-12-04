extends Spatial
class_name Spaceship

onready var bullet_scene = preload("res://objects/spaceship/bullet/bullet.tscn")
onready var gameplay = get_node("../../")
var speed = 10
var x_speed = 8
var cooldown = 0.06 # s
var cooldown_timer = 0 # s
var movement = Vector2()

signal destroyed


func _process(delta):
	movement = Vector2()
	if Input.is_action_pressed("ui_left"):
		movement.x = -delta * x_speed
	if Input.is_action_pressed("ui_right"):
		movement.x = delta * x_speed

	translation.x += movement.x
	translation.x = clamp(translation.x, gameplay.top_left.x, gameplay.bot_right.x)

	if Input.is_action_pressed("ui_down"):
		movement.y = -delta * speed
	if Input.is_action_pressed("ui_up"):
		movement.y = speed * delta

	translation.y += movement.y
	translation.y = clamp(translation.y, gameplay.bot_right.y, gameplay.top_left.y)

	if Input.is_action_pressed("fire"):
		if cooldown_timer <= 0:
			fire()
			cooldown_timer = cooldown
		cooldown_timer -= delta


func fire():
	var b = bullet_scene.instance()
	b.translation = translation
	b.translation.y += 1
	get_parent().add_child(b)


func _on_Area_area_entered(area):
	if area is Enemy:
		queue_free()
		emit_signal("destroyed")
