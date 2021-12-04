extends Area
class_name Enemy

signal killed

var speed = 6

func _ready():
	translation.x = rand_range(-5, 5)


func _process(delta):
	translation.y -= delta * speed


func _on_Enemy_area_entered(area):
	if area is Bullet:
		emit_signal("killed", self)
		area.queue_free()
		queue_free()


func _on_VisibilityNotifier_camera_exited(camera):
	queue_free()
