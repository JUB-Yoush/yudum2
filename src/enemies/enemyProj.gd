extends Area2D


var velocity:Vector2 
var speed:int
var damage:int = 1

func _ready() -> void:
	connect("area_entered",self,"on_area_entered")
	pass

func _physics_process(delta: float) -> void:
	rotation = velocity.angle()
	position += velocity * speed


func on_area_entered(area:Area2D):
	print('1')
	if area.get_parent() != null and area.get_parent().is_in_group("player") == true:
		print('2')
		var player = area.get_parent()
		if player._state != player.STATES.DASHING:
			player.take_damage(damage)
			queue_free()
			
