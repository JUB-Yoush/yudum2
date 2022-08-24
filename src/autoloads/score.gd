extends Node

var score:int = 0
var wave:int = 0
var gameOverScreen: = load("res://src/screens/LoseScreen.tscn")
signal score_changed(score)
signal wave_changed(wave)


func _ready() -> void:
	pass
