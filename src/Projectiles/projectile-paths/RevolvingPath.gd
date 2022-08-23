extends ProjectilePath

var velocity:Vector2 = Vector2.ZERO
var angle_shift:float = 0.1
var angle

func _ready() -> void:
	projInstance = ProjTypeScene.instance()
	projInstance.lifespan += lifespan
	projInstance.position = position
	projInstance.damage += extra_damage
	ammo_cost += projInstance.ammo_cost
	get_parent().add_child(projInstance)


func update_velocity():
	#velocity = speed * velocity
	#print(angle)
	angle = velocity.angle() + 5
	velocity = Vector2(cos(angle),sin(angle)) * speed
	pass

func _physics_process(delta: float) -> void:
	print(velocity)
	position += Vector2(3,3) + velocity
