extends Spatial

class_name NPC

var resId : int
var myResources = 0
export var text_to_show = "";
export var ressouces_type = 0;

func _ready():
	$Label3D.text = text_to_show;


func _on_Area_body_entered(body):
	if body.name == "Player":
		get_node("Label3D").visible = true
		myResources += body.emptyResource(ressouces_type)
		GameSytem.residents_ressources[ressouces_type] = myResources;


func _on_Area_body_exited(body):
	if body.name == "Player":
		get_node("Label3D").visible = false
