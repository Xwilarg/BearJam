extends Node

var permissiveness = .5 # How much error margin you have when clicking a note
var maxBurst = 3 # Number of patterns that can follow each others
var delayBetweenNotes = 0.1 # Number of seconds between each notes
var songDuration = 30 # Duration of the song

var day_time = 0;
var note_speed = 10;

var finalScore: int

enum ResourceType { WOOD, ROCK, SCRAP, CANDY}
var residents_ressources = [0, 0, 0, 0];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
