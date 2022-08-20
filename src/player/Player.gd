extends KinematicBody2D

export var max_speed:int = 250 
export var friction:int = 2000
export var acceleration:int = 2000
export var cursor_radius = 48
var crosshair_x 
var crosshair_y 

var proj_type_path:String = "res://src/Projectiles/projectile-types/Lemon.tscn"
var proj_path_path:String = "res://src/Projectiles/projectile-paths/ThreeWayPath.tscn"
var ProjTypeScene:PackedScene = load(proj_type_path)
var ProjPathScene:PackedScene = load(proj_path_path)

var velocity:Vector2 = Vector2.ZERO
var input_vector:Vector2 = Vector2.ZERO

onready var crosshair:Position2D = $Crosshiar

func _ready() -> void:
	#var proj_tscn_path = "res://src/Projectiles/projectile-types/Lemon.tscn"
	pass


func _physics_process(delta: float) -> void:
	get_input()
	update_crosshair()
	shoot()
	if input_vector != Vector2.ZERO:
		
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)
	velocity = move_and_slide(velocity)
	

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
	if Input.is_action_just_pressed("shoot"):
		var projSpawner:ProjectilePath = ProjPathScene.instance()
		projSpawner.ProjTypeScene = ProjTypeScene
		print(projSpawner.ProjTypeScene)
		projSpawner.position = crosshair.global_position
		projSpawner.player_position = position
		projSpawner.crosshair_vector = Vector2(crosshair_x,crosshair_y)
		get_parent().add_child(projSpawner)
