extends Spatial

func _ready():
	$Label3D.text += str(GameSytem.finalScore)
