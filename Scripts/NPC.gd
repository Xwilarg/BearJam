extends StaticBody

class_name NPC

var resId : int
var myResources = 0

func _on_Area_body_entered(body):
	if body.name == "Player":
		get_node("Label3D").visible = true
		myResources += body.emptyResource(0)


func _on_Area_body_exited(body):
	if body.name == "Player":
		get_node("Label3D").visible = false
