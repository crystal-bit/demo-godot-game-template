extends Area
class_name Bullet

var speed = 15

func _process(delta):
	translation.y += delta * speed


func _on_VisibilityNotifier_camera_exited(camera):
	queue_free()
