extends Node

var permissiveness = .5 # How much error margin you have when clicking a note
var maxBurst = 3 # Number of patterns that can follow each others
var delayBetweenNotes = 0.1 # Number of seconds between each notes
var songDuration = 30 # Duration of the song

var day_time = 0;
var note_speed = 10;

var finalScore: int

enum ResourceType { WOOD, ROCK, SCRAP, CANDY}
var residents_ressources = [0, 0, 0, 0]

func updateMainParameters():
	var wood = residents_ressources[ResourceType.WOOD]
	var rock = residents_ressources[ResourceType.ROCK]
	var scrap = residents_ressources[ResourceType.SCRAP]
	var candy = residents_ressources[ResourceType.CANDY]
	if candy > 10:
		candy = 10
	permissiveness = 1 - (.1 * candy)
	maxBurst = 1 + (rock / 10)
	delayBetweenNotes = 0.2 - (0.01 * scrap)
	songDuration = 10 + (5 * wood)

func go_to_scene(path):
	get_tree().change_scene(path)
	pass
