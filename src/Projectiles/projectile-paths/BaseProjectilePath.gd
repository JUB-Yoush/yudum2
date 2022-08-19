extends Node2D
class_name ProjectilePath

var ProjTypeScene:PackedScene

var projType:ProjectileType
var velocity:Vector2 = Vector2.ZERO
var crosshair_position:Vector2
var player_position:Vector2
var crosshair_angle:float
var crosshair_vector:Vector2
var speed:int

func _ready() -> void:
	projType = ProjTypeScene.instance()
	pass

func update_velocity() -> void:
	pass

func _physics_process(delta: float) -> void:
	update_velocity()
	
