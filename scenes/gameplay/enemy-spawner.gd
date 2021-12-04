extends Node

onready var enemy_scene = preload("res://objects/enemy/enemy.tscn")

signal enemy_killed


func _ready():
	$Timer.start()


func spawn():
	var enemy: Enemy = enemy_scene.instance()
	enemy.translation.y = 20
	enemy.connect("killed", self, "on_enemy_killed")
	add_child(enemy)


func on_enemy_killed(enemy):
	emit_signal("enemy_killed")


func _on_Timer_timeout():
	spawn()
