extends Node

var clock = Timer.new()

var day_time = 0
var note_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	clock.one_shot = true;
	clock.connect("timeout", self, "change_to_night");
	get_tree().get_current_scene().add_child(clock);
	clock.start(600);
	pass # Replace with function body.

func _change_to_night():
	day_time = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
