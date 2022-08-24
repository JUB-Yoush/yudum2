extends Enemy

onready var Proj:PackedScene = load("res://src/enemies/enemyProj.tscn")
export var proj_speed:int = 5
onready var shotTimer = $ShotTimer
var shotTime:float = 0.5

func _ready() -> void:
	playerDetector.connect("area_exited",self,"on_pdetector_area_exited")
	player = get_parent().get_parent().get_node('Player')
	player_position = player.position
	shotTimer.connect("timeout",self,"on_shottimer_timeout")
	shotTimer.wait_time = shotTime
	shotTimer.autostart = true
	shotTimer.one_shot = false
	

func _physics_process(delta: float) -> void:
	#animPlayer.play('walk')
	if velocity.x > 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	match _state:
		STATES.DEFAULT:
			state_defualt()
		STATES.PLAYER_FOUND:
			state_player_found()
		STATES.PRONE:
			state_prone()
	
func state_defualt():
	var rounded_p_position = Vector2(floor(player_position.x),floor(player_position.y))
	var rounded_position = Vector2(floor(position.x),floor(position.y))
	var comparison_position = Vector2(abs(rounded_p_position.x - rounded_position.x),abs(rounded_p_position.y - rounded_position.y))
	#print(comparison_position)
	velocity = (player_position - position).normalized() * speed
	if comparison_position.x < 10 and comparison_position.y < 10:
		#print('same')
		player_position = player.position
	#prints(rounded_p_position,rounded_position)
	velocity = move_and_slide(velocity)
	pass

func state_player_found():
	
	
	pass

func state_prone():
	sprite.modulate = ("ff0000")
	if player_position == null:
		velocity = Vector2(rand_range(0, 10), rand_range(0, 10)).normalized() * prone_speed
	else:
		velocity = -(player_position - position).normalized() * prone_speed
	velocity = move_and_slide(velocity)
	pass

func player_detected(detected_player:KinematicBody2D) -> void:
	if _state != STATES.PRONE:
		player = detected_player
		player_position = player.position
		if _state == STATES.DEFAULT:
			_state = STATES.PLAYER_FOUND
	else:
		player_position = detected_player.position

func on_pdetector_area_exited(area:Area2D):
	if area.get_parent() != null and area.get_parent().is_in_group("player"):
		if _state == STATES.PLAYER_FOUND:
			_state = STATES.DEFAULT

func on_shottimer_timeout():
	if _state == STATES.PLAYER_FOUND:
		animPlayer.play("shoot")

func spawn_proj():
	
	var proj = Proj.instance()
	proj.speed = proj_speed
	proj.velocity = (player.position - position).normalized()
	proj.position = position
		#print(proj.velocity)
	get_parent().add_child(proj)
