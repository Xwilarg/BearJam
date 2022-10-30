extends Spatial

func _ready():
	var woodLabel = $UI/VBoxContainer/TextureRect/Wood
	var rockLabel = $UI/VBoxContainer/TextureRect2/Rock
	var scrapLabel = $UI/VBoxContainer/TextureRect3/Light
	var candyLabel = $UI/VBoxContainer/TextureRect4/Candy
	woodLabel.text = "City defense: " + str(GameSytem.wood()) + " pieces of wood,\nsong will last " + str(GameSytem.songDuration) + " seconds"
	rockLabel.text = "Towers: " + str(GameSytem.rock()) + " rocks,\nmax number of pattern bursts of " + str(GameSytem.maxBurst)
	scrapLabel.text = "Speakers: " + str(GameSytem.scrap()) + " scraps,\ndelay between notes of " + str(GameSytem.delayBetweenNotes) + " seconds"
	candyLabel.text = "Spotlights: " + str(GameSytem.candy()) + " candies,\ndistance to hit a note of " + ("%.2f" % GameSytem.permissiveness) + " cm"

func _on_Button_pressed():
	GameSytem.go_to_scene("res://Scenes/Night.tscn");
