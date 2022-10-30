extends Spatial

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton && event.pressed:
		print("ray")
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_from = $Camera.project_ray_origin(mouse_pos)
		var ray_to = ray_from + $Camera.project_ray_normal(mouse_pos) * 1000
		var space_state = get_world().direct_space_state
		var selection = space_state.intersect_ray(ray_from, ray_to)
		if selection:
			var name = selection.collider.name
			if name == "Play":
				get_tree().change_scene("res://Scenes/Day.tscn")
