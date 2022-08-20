extends ProjectilePath

onready var projInstance1:ProjectileType = ProjTypeScene.instance()
onready var projInstance2:ProjectileType = ProjTypeScene.instance()
onready var projInstance3:ProjectileType = ProjTypeScene.instance()

var proj1Velocity:Vector2 = Vector2.ZERO
var proj2Velocity:Vector2 = Vector2.ZERO
var proj3Velocity:Vector2 = Vector2.ZERO

var proj2Offset:float = 0.7
var proj3Offset:float = -0.7

func _ready() -> void:
	speed = 3
	projInstance1.position = position
	projInstance2.position = position
	projInstance3.position = position
	get_parent().add_child(projInstance1)
	get_parent().add_child(projInstance2)
	get_parent().add_child(projInstance3)
	
	
func update_velocity() -> void:
	var proj2Angle = crosshair_vector.normalized().angle() + proj2Offset
	var proj2Vector = Vector2(cos(proj2Angle),sin(proj2Angle))
	var proj3Angle = crosshair_vector.normalized().angle() + proj3Offset
	var proj3Vector = Vector2(cos(proj3Angle),sin(proj3Angle))
	proj1Velocity = crosshair_vector.normalized() * speed
	proj2Velocity = proj2Vector * speed
	proj3Velocity = proj3Vector * speed 

func _physics_process(delta: float) -> void:
	projInstance1.position += proj1Velocity
	projInstance2.position += proj2Velocity
	projInstance3.position += proj3Velocity
