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

func wood() -> int:
	return residents_ressources[ResourceType.WOOD];

func rock() -> int:
	return residents_ressources[ResourceType.ROCK];

func scrap() -> int:
	return residents_ressources[ResourceType.SCRAP];

func candy() -> int:
	return residents_ressources[ResourceType.CANDY];

func updateMainParameters():
	var wood = wood()
	var rock = rock()
	var scrap = scrap()
	var candy = candy()
	if candy > 10:
		candy = 10
	permissiveness = 1 - (.05 * candy)
	if permissiveness < 0.1:
		permissiveness = 0.1
	maxBurst = 1 + (rock / 10)
	delayBetweenNotes = 0.2 - (0.005 * scrap)
	if delayBetweenNotes < 0.05:
		delayBetweenNotes = 0.05
	songDuration = 10 + (2 * wood)

func go_to_scene(path):
	get_tree().change_scene(path)
	pass
