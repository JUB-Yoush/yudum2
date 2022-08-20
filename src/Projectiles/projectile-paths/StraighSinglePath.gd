extends ProjectilePath

var velocity:Vector2 = Vector2.ZERO


func _ready() -> void:
	projInstance = ProjTypeScene.instance()
	speed = 5
	projInstance.position = position
	get_parent().add_child(projInstance)
	
	
func update_velocity() -> void:
	velocity = crosshair_vector.normalized() * speed

func _physics_process(delta: float) -> void:
	projInstance.position += velocity
