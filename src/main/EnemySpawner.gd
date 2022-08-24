extends Node2D

var wave:int = 2
onready var EnemySpawnTimer:= $EnemySpawnTimer
var enemyChildren:Array
var enemy_spawn_time:float = 2
var spawning:bool = false

var Koopa:PackedScene = load("res://src/enemies/Koopa.tscn")
var Goomba:PackedScene = load("res://src/enemies/goomba.tscn")
var enemy_types:Array = [Koopa,Goomba]

func _ready() -> void:
	enemyChildren = get_children()
	EnemySpawnTimer.connect("timeout",self,"on_enemy_spawn_timeout")
	#print('wave')
	make_wave(wave)
	pass

func _physics_process(delta: float) -> void:
	#prints(get_children().size() == 1,not spawning)
	if get_children().size() == 1 and not spawning:
		print('she took the kids')
		spawning = true
		wave += 1
		Score.wave = wave
		Score.emit_signal('wave_changed',wave)
		make_wave(wave)
	pass

func spawn_enemies(enemy_count):
	#prints("wave",wave)
	var enemies_spawned:int = 0
	while enemies_spawned < enemy_count:
		#print(enemies_spawned)
		EnemySpawnTimer.wait_time = enemy_spawn_time
		EnemySpawnTimer.start()
		yield(EnemySpawnTimer,"timeout")
		enemies_spawned += 1
		#print(enemies_spawned)
	spawning = false
	
func make_wave(wave:int):
	var enemy_count = int(wave/2 + 1)
	spawn_enemies(enemy_count)
	

func on_enemy_spawn_timeout():
	if spawning == true:
		spawn_enemy()
	
func spawn_enemy():
	randomize()
	
	var rng:int = randi() % enemy_types.size() 
	var enemyInst = enemy_types[rng].instance()
	
	var type_rng:int = randi() % projRef.type_array.size()
	#print(projRef.type_array.size())
	enemyInst.type_mutagen = load(projRef.type_array[type_rng])
	
	
	var path_rng:int = randi() % projRef.path_array.size()
	#print( projRef.path_array.size())
	enemyInst.path_mutagen = load(projRef.path_array[type_rng])
	
	var enemy_positions:Array = get_parent().get_node("EnemySpawnPos").get_children()
	var pos_rng:int = randi() % enemy_positions.size()
	enemyInst.position = enemy_positions[pos_rng].position
	add_child(enemyInst)
