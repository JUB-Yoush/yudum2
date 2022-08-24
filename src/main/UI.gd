extends Control

func _ready() -> void:
	var player = get_parent().get_parent().get_node("Player")
	player.connect("hp_changed",self,"update_hp_label")
	player.connect("max_hp_changed",self,"update_max_hp_label")
	player.connect("ammo_changed",self,"update_ammo_label")
	player.connect("max_ammo_changed",self,"update_max_ammo_label")
	player.connect("proj_changed",self,"update_proj_label")
	Score.connect("score_changed",self,"update_score_label")
	Score.connect("wave_changed",self,"update_wave_label")
	pass


onready var hpLabel = $VBoxContainer/HPLabel
onready var ammoLabel = $VBoxContainer/AmmoLabel
onready var projTypeLabel = $VBoxContainer/ProjTypeLabel
onready var projPathLabel = $VBoxContainer/ProjPathLabel
onready var scoreLabel = $VBoxContainer/ScoreLabel
onready var waveLabel = $VBoxContainer/WaveLabel

func update_hp_label(hp,max_hp):
	hpLabel.text = ("HP: "+str(hp)+"/"+str(max_hp))
	pass

func update_max_hp_label(hp,max_hp):
	hpLabel.text = ("HP: "+str(hp)+"/"+str(max_hp))
	pass

func update_ammo_label(ammo,max_ammo):
	ammoLabel.text = ("AMMO: "+str(ammo)+"/"+str(max_ammo))
	pass

func update_max_ammo_label(ammo,max_ammo):
	ammoLabel.text = ("AMMO: "+str(ammo)+"/"+str(max_ammo))
	pass

func update_proj_label(pti,ppi):
	#prints(pti.id,ppi.id)
	projTypeLabel.text = "TYPE: " + str(pti.id)
	projPathLabel.text = "PATTERN: " + str(ppi.id)
	pass

func update_score_label(score):
	scoreLabel.text = "SCORE: " + str(Score.score)
	
func update_wave_label(wave):
	scoreLabel.text = "WAVE: " + str(Score.wave)
