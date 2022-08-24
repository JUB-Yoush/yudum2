extends Control

onready var loseLabel = $VBoxContainer/LoseLabel
onready var scoreLabel = $VBoxContainer/ScoreLabel
onready var playAgainBtn = $VBoxContainer/PlayAgain
onready var main = load("res://src/main/Main.tscn")


func _ready() -> void:
	playAgainBtn.connect("pressed",self,"play_again")
	scoreLabel.text = "SCORE: " + str(Score.score)
	pass


func play_again():
	get_tree().change_scene("res://src/main/Main.tscn")
	pass
