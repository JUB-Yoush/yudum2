extends Area2D
class_name ProjectileType

export var id:String 
export var speed:int
export var damage:int
export var lifespan:float
export var ammo_cost:int
export var cooling_time:float
onready var lifespanTimer = $Lifespan
var spawnerPath:ProjectilePath


func _ready() -> void:
	connect("area_entered",self,"on_area_entered")
	lifespanTimer.wait_time = lifespan
	lifespanTimer.connect("timeout",self,"on_lifespan_timeout")
	lifespanTimer.start()
	

func on_area_entered(area:Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent != null and area_parent.is_in_group("enemy"):
		projectile_action(area_parent)
	pass

func _physics_process(delta: float) -> void:
	pass
	
func projectile_action(area_parent:KinematicBody2D):
	# changes depending on the shot type
	pass

func on_lifespan_timeout():
	#print(lifespan)
	erase()



func erase():
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	pass
