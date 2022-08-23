extends ProjectilePath

var velocity:Vector2 = Vector2.ZERO


func _ready() -> void:
	projInstance = ProjTypeScene.instance()
	projInstance.lifespan += lifespan
	projInstance.position = position
	projInstance.damage += extra_damage
	ammo_cost += projInstance.ammo_cost
	get_parent().add_child(projInstance)
	
	
func update_velocity() -> void:
	velocity = crosshair_vector.normalized() * speed
	projInstance.rotation = velocity.angle()

func _physics_process(delta: float) -> void:
	if projInstance != null:
		projInstance.position += velocity + (player_velocity/100)
