extends ProjectilePath




func _ready() -> void:
	speed = 5
	projType.position = position
	get_parent().add_child(projType)
	
	
func update_velocity() -> void:
	velocity = crosshair_vector.normalized() * speed

func _physics_process(delta: float) -> void:
	projType.position += velocity
