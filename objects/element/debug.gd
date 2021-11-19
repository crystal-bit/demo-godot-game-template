extends Control


func _process(delta):
	$Label.text = get_node("../").state
