extends Spatial

var meters_x = 0
var meters_y = 0

export var scroll_speed = 4

func _ready():
	for node in get_tree().get_nodes_in_group("scroll_objects"):
		var n: Spatial = node
		var visibility_notifier = n.find_node("VisibilityNotifier")
		if visibility_notifier:
			visibility_notifier.connect("camera_exited", self, "on_object_camera_exited", [n])

func on_object_camera_exited(camera, node: Spatial):
	node.translation.y = 20

func _process(delta):
	for node in get_tree().get_nodes_in_group("scroll_objects"):
		var n: Spatial = node
		n.translation.y -= delta * scroll_speed
		if n is Meteor:
			n.rotate(Vector3(1, 0, 0), delta * n.get_meta("rotate_speed"))

