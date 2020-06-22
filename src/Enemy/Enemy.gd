extends Area2D

export var speed: float = 200.0
var path = []
var path_point = Vector2()
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var _state = null
enum STATES {IDLE, FOLLOW}


func _ready() -> void:
	#change_state()
	pass
	
	
func change_state():
		path = get_parent().getPathTo()
		
		if not path or len(path) == 1:
			print("state selesai")
			return
		
		path_point = path[0]
	


#func _process(delta: float) -> void:
#
#	var next_point = moveEnemy(path_point)
#
#	if next_point:
#		path.remove(0)
#		if len(path) == 0:
#			position = path_point
#			print("process Selesai")
#			return
#		path_point = path[0]
#
#

func moveEnemy(point_world_map):
	var MASS = 10.0
	var ARRIVE_DISTANCE = 10.0
	
	var desired_velocity = (point_world_map - position).normalized() * speed
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	
	position += velocity * get_physics_process_delta_time()
	
	return position.distance_to(point_world_map) < ARRIVE_DISTANCE



func _on_Enemy_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("GameOver")
		get_tree().paused = true
