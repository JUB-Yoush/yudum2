extends ProjectilePath


onready var projInstance1:ProjectileType = ProjTypeScene.instance()
onready var projInstance2:ProjectileType = ProjTypeScene.instance()
var proj1Velocity:Vector2 = Vector2.ZERO
var proj2Velocity:Vector2 = Vector2.ZERO



func _ready() -> void:
	projInstance1.position = local_crosshair_position + player_position
	projInstance2.position = -local_crosshair_position + player_position
	projInstance1.lifespan += lifespan
	projInstance2.lifespan += lifespan
	projInstance1.damage += extra_damage
	projInstance2.damage += extra_damage
	cooling_time += projInstance1.cooling_time
	get_parent().add_child(projInstance1)
	get_parent().add_child(projInstance2)
	pass

func update_velocity():
	proj1Velocity = crosshair_vector.normalized() * speed
	proj2Velocity = -crosshair_vector.normalized() * speed

func _physics_process(delta: float) -> void:
	projInstance1.position += proj1Velocity 
	projInstance2.position += proj2Velocity 
