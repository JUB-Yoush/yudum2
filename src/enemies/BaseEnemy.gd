extends KinematicBody2D
class_name Enemy

# what are all enemies going to have
# a mutagen they drop
# health
# a way to find the players position
# an area to detect the player entering

onready var hitbox := $Hitbox
onready var playerDetector := $PlayerDetector
var velocity:Vector2
var damage:int
var hp:int
var speed:int 
var prone_speed:int
var mutagen:PackedScene
var player:KinematicBody2D
var player_position:Vector2
var prone_hp:int


enum STATES {DEFAULT,PLAYER_FOUND,PRONE}

var _state = STATES.DEFAULT

func _ready() -> void:
	hitbox.connect("area_entered",self,"on_hitbox_area_entered")
	playerDetector.connect("area_entered",self,"on_pdetector_area_entered")
	pass

func on_hitbox_area_entered(area:Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent == null or area_parent.is_in_group("main"):
		area_parent = area
	if area_parent.is_in_group("p_projectile"):
		hit_by_proj(area)

func take_damage(damage:int):
	#print("hit by " + str(damage))
	hp = max(0,hp-damage)
	if hp <= prone_hp:
		_state = STATES.PRONE
	

func hit_by_proj(area:ProjectileType) -> void:
	take_damage(area.damage)
	area.erase()

func on_pdetector_area_entered(area:Area2D) -> void:
	#print(area.get_parent())
	if area.get_parent() != null and area.get_parent().is_in_group("player"):
		player_detected(area.get_parent())

func player_detected(detected_player:KinematicBody2D) -> void:
	#print('p detected')
	pass
