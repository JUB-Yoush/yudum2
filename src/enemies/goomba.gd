extends Enemy

func _ready() -> void:
	hp = 10
	speed = 150
	prone_speed = 50
	prone_hp = 3
	mutagen = load("res://src/Projectiles/projectile-types/Lemon.tscn")
	pass


func _physics_process(delta: float) -> void:
	match _state:
		STATES.DEFAULT:
			state_defualt()
		STATES.PLAYER_FOUND:
			state_player_found()
		STATES.PRONE:
			state_prone()
		

func state_defualt():
	pass

func state_player_found():
	var bodies_in_detector:Array = playerDetector.get_overlapping_bodies()
	if bodies_in_detector.size() > 0:
		for body in bodies_in_detector:
			if body.is_in_group('player'):
				player_detected(body)
			
	var rounded_p_position = Vector2(floor(player_position.x),floor(player_position.y))
	var rounded_position = Vector2(floor(position.x),floor(position.y))
	var comparison_position = Vector2(abs(rounded_p_position.x - rounded_position.x),abs(rounded_p_position.y - rounded_position.y))
	#print(comparison_position)
	velocity = (player_position - position).normalized() * speed
	if comparison_position.x < 10 and comparison_position.y < 10:
		#print('same')
		player_position = player.position
	velocity = move_and_slide(velocity)
	pass

func state_prone():
	if player_position == null:
		velocity = Vector2(rand_range(0, 10), rand_range(0, 10)).normalized() * prone_speed
	else:
		velocity = -(player_position - position).normalized() * prone_speed
	velocity = move_and_slide(velocity)

func player_detected(detected_player:KinematicBody2D) -> void:
	if _state != STATES.PRONE:
		player = detected_player
		player_position = player.position
		if _state == STATES.DEFAULT:
			_state = STATES.PLAYER_FOUND
	else:
		player_position = detected_player.position
		

