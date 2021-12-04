extends Control

onready var value := $ColorRect/VBoxContainer/HBoxContainer/Value

func set_score(val: String):
	value.text = val


func _on_Button_pressed():
	Game.change_scene("res://scenes/gameplay/gameplay.tscn")
