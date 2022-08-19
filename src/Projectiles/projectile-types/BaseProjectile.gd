extends Area2D
class_name ProjectileType

export var max_speed:int

func _ready() -> void:
	connect("area_entered",self,"on_area_entered")

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


