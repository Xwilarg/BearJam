extends Node

export var permissiveness = 1.0 # How much error margin you have when clicking a note, must be < 2
export var maxBurst = 3 # Number of patterns that can follow each others
export var delayBetweenNotes = 0.1 # Number of seconds between each notes
export var songDuration = 180 # Duration of the song

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
