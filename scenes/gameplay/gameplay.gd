extends Node

var top_left: Vector3
var bot_right: Vector3
var center: Vector3

# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	set_process(false)
	var spaceship = $Spatial/Spaceship
	var camera = $Spatial/Camera
	var d = camera.translation.distance_to(spaceship.translation)
	top_left = camera.project_position(Vector2(0, 0), d)
	bot_right = camera.project_position(Vector2(Game.size.x, Game.size.y), d)
	center = camera.project_position(Vector2(Game.size.x / 2, Game.size.y / 2), d)
	spaceship.translation = center
	preload_shaders()


# TODO: test it with Godot 3.5
func preload_shaders():
	var objs = [
		preload("res://assets/space/meteor.tscn"),
		preload("res://objects/spaceship/bullet/bullet.tscn"),
		preload("res://objects/enemy/enemy.tscn")
	]
	var node = Node.new()
	var i = 0
	for obj in objs:
		var n = obj.instance()
		node.add_child(n)
		n.translation.y = i * 2
		i += 1
	add_child(node)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	node.queue_free()


# `start()` is called when the graphic transition ends.
func start():
	set_process(true)


func _on_Spaceship_destroyed():
	var gameover = load("res://scenes/gameplay/game-over/game-over.tscn").instance()
	add_child(gameover)
	gameover.set_score($GUI.score_value.text)
