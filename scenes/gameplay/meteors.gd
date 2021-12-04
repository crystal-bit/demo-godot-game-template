extends Node
export (PackedScene) var meteor_scene

# TODO: use the same stars' logic
func _process(delta):
	if randf() > 0.99:
		spawn()


func spawn():
	var meteor: Spatial = meteor_scene.instance()
	add_child(meteor)
	meteor.add_to_group("scroll_objects")
	meteor.translation.z = rand_range(-10, -20)
	meteor.translation.y = 40
	meteor.scale = rand_range(.3, 1) * Vector3.ONE
	meteor.translation.x = rand_range(-20, 20)
	meteor.rotate(RandUtils.vec3().normalized(), randf() * 3)
	meteor.set_meta("rotate_speed", randf() * .5)
	var visibility_notifier = meteor.find_node("VisibilityNotifier")
	if visibility_notifier:
		visibility_notifier.connect("camera_exited", self, "on_camera_exited", [meteor])

func on_camera_exited(_camera, meteor):
	meteor.queue_free()
