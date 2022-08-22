extends KinematicBody2D
class_name Player


export var max_speed:int = 250 

var hp = 5

export var dash_speed:Vector2 = Vector2(600,600)
var dash_cost := 3
var dash_frames:= 6
var dash_frame := 0
var dashing := false

export var max_ammo:int = 10
var ammo = max_ammo
var ammo_regen_time:float = 0.75
export var friction:int = 2000
export var acceleration:int = 2000
export var cursor_radius = 48
var crosshair_x 
var crosshair_y 


var gun_cooling := false
var ammo_regen_yeilding := false
var gun_timer_running := false

var proj_type_path:String = "res://src/Projectiles/projectile-types/Apple.tscn"
var proj_path_path:String = "res://src/Projectiles/projectile-paths/StraighSinglePath.tscn"
var ProjTypeScene:PackedScene = load(proj_type_path)
var ProjPathScene:PackedScene = load(proj_path_path)
var projTypeInst:ProjectileType = ProjTypeScene.instance()
var projPathInst:ProjectilePath = ProjPathScene.instance()


var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO
#var last_input = Vector2.ZERO

onready var crosshair:Position2D = $Crosshiar
onready var dashCooldown:Timer = $DashCooldown
onready var ammoRegenTimer:Timer = $AmmoRegen
onready var hitboxArea:Area2D = $Hitbox


enum STATES {IDLE,SHOOTING,DASHING,DASH_ENDLAG}

var _state = STATES.IDLE
func _ready() -> void:
	hitboxArea.connect("area_entered",self,"on_hitbox_area_entered")
	ammoRegenTimer.connect("timeout",self,"on_ammoRegen_timeout")
	ammoRegenTimer.wait_time = ammo_regen_time
	ammoRegenTimer.start()
	pass


func _physics_process(delta: float) -> void:
	#print(_state)
	#print(gunCooldown.time_left)
	match _state:
		STATES.IDLE:
			state_idle(delta)
		STATES.SHOOTING:
			state_shooting(delta)
		STATES.DASHING:
			state_dashing(delta)
		STATES.DASH_ENDLAG:
			state_dash_endlag(delta)
		
	

func state_idle(delta):
	get_input()
	update_crosshair()
	shoot()
	move(delta)
	dash(delta)
	#regen_ammo()
	pass

func state_shooting(delta):
	#print('state shooting')
	ammoRegenTimer.start()
	ammo = max(0, ammo - projPathInst.ammo_cost)
	var projSpawner:ProjectilePath = ProjPathScene.instance()
	projSpawner.ProjTypeScene = ProjTypeScene
	#print(projSpawner.ProjTypeScene)
	projSpawner.position = crosshair.global_position
	projSpawner.player_position = position
	projSpawner.player_velocity = velocity
	projSpawner.crosshair_vector = Vector2(crosshair_x,crosshair_y)
	get_parent().add_child(projSpawner)
	_state = STATES.IDLE

func state_dashing(delta):
	dashing = true
	velocity = dash_speed * input_vector
	move_and_slide(velocity)
	if dash_frame < dash_frames:
		dash_frame += 1
	else:
		dash_frame = 0
		dashing = false
		_state = STATES.IDLE

func state_dash_endlag(delta):
	pass

# STATE COMPONENTS
func get_input():
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()

func update_crosshair():
	var diff:Vector2 = get_global_mouse_position() - position
	var rad = diff.angle()
	crosshair_x = (cursor_radius * cos(rad)) 
	crosshair_y = (cursor_radius * sin(rad))
	crosshair.position = Vector2(crosshair_x, crosshair_y)

func shoot() -> void:
	#prints(Input.is_action_just_pressed("shoot"),ammo > projPathInst.ammo_cost,gun_cooling == false)
	if Input.is_action_just_pressed("shoot") and ammo > projPathInst.ammo_cost and gun_cooling == false:
		gun_cooling = true
		_state = STATES.SHOOTING
		yield(get_tree().create_timer(projPathInst.cooling_time), "timeout")
		gun_cooling = false

func move(delta:float) -> void:
	if input_vector != Vector2.ZERO:
		
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)
	velocity = move_and_slide(velocity)
	
func dash(delta:float) -> void:
	if Input.is_action_just_pressed("dash") and ammo > dash_cost and not dashing:
		ammo = max(0,ammo - dash_cost)
		_state = STATES.DASHING
	pass

func regen_ammo() -> void:
	if ammo_regen_yeilding == false:
		ammo_regen_yeilding = true
		ammo = min(ammo + 1, max_ammo)
		yield(get_tree().create_timer(ammo_regen_time), "timeout")
		ammo_regen_yeilding = false

func update_weapon(new_proj_path_path:String, new_proj_type_path:String) -> void:
	pass

# SIGNALS
func on_hitbox_area_entered(area:Area2D):
	if area.get_parent() != null and area.get_parent().is_in_group("enemy"):
		#touching enemy
		var enemy:Enemy = area.get_parent()
		prints(enemy._state == enemy.STATES.PRONE,_state == STATES.DASHING)
		if enemy._state == enemy.STATES.PRONE and _state == STATES.DASHING:
			ate_enemy()
		else:
			take_damage(enemy.damage)

	pass

func on_ammoRegen_timeout():
	ammo = min(ammo + 1, max_ammo)
	ammoRegenTimer.wait_time = ammo_regen_time
	#ammoRegenTimer.start()
	pass

func ate_enemy():
	pass

func take_damage(damage:int):
	hp = max(0,hp-damage)
	pass
