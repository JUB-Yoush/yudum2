extends Node2D
class_name ProjectilePath

var ProjTypeScene:PackedScene

export var id:String 
var projInstance
var crosshair_position:Vector2
var local_crosshair_position:Vector2
var player_position:Vector2
var player_velocity:Vector2 = Vector2.ZERO
var crosshair_angle:float
var crosshair_vector:Vector2

export var speed:int
export var ammo_cost:int
export var cooling_time:float
export var extra_damage:int
export var base_ammo:int
export var lifespan:float

func _ready() -> void:
	pass

func update_velocity() -> void:
	pass

func _physics_process(delta: float) -> void:
	update_velocity()
	
