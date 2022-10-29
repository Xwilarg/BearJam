extends StaticBody

var myResources = 0

func _ready():
	pass

func _on_Area_body_entered(body):
	if body.name == "Player":
		get_node("Label3D").visible = true
		myResources += body.emptyResource(0)


func _on_Area_body_exited(body):
	if body.name == "Player":
		get_node("Label3D").visible = false
