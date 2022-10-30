extends Spatial


var clock = Timer.new()

var day_time = 0
var note_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(clock);
	clock.one_shot = true;
	clock.connect("timeout", self, "_change_to_night");
	clock.start(4);
	pass # Replace with function body.

func _change_to_night():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameSytem.updateMainParameters()
	GameSytem.go_to_scene("res://Scenes/Interlude.tscn")
	pass

func get_time_left():
	return clock.time_left;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
