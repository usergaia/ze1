extends Node

var coins_collected = 0
const TOTAL_COINS = 15
@onready var score_label: Label = %ScoreLabel
@onready var congrats_label: Label = %CongratsLabel
@onready var win_sound: AudioStreamPlayer2D = $WinSound

func add_point():
	coins_collected += 1

	if coins_collected == TOTAL_COINS:
		win_sound.play()
		score_label.visible = false
		congrats_label.text = "Congrats! You collected all the coins!"
		congrats_label.visible = true
	else:
		congrats_label.visible = false

	score_label.text = "Coins collected (%s/%s)" % [str(coins_collected), TOTAL_COINS]
	
