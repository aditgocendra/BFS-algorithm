extends Node2D

onready var _tile = $TileMap
var simpul

func _ready() -> void:
	simpul = _tile.get_used_cells()
	var graph = getNeighbours()
	var enemy_position  = $TileMap.world_to_map($Enemy.position)
	var player_position = $TileMap.world_to_map($Player.position)
	BreadthFS(graph, player_position, enemy_position)
	
	
func getNeighbours():
	var result = [[null, null]]
	for i in range (simpul.size()):
		var pos = _tile.map_to_world(simpul[i])
		var half_size = _tile.cell_size / 2
	
		pos.x += half_size.x
		pos.y += half_size.y
		result.append([pos, getDataNeighbours(pos)])
	result.remove(0)
	
	return result
	
	
func getDataNeighbours(_pos):
	var result = []
	var posNeigh = {
		"right":{
			"x":_pos.x + 128,
			"y":_pos.y
		},
		"left":{
			"x":_pos.x - 128,
			"y":_pos.y
		},
		"up":{
			"x":_pos.x ,
			"y":_pos.y + 128
		},
		"down":{
			"x":_pos.x ,
			"y":_pos.y - 128
		}
	}
	posNeigh = posNeigh.values()
	
	for i in range(posNeigh.size()):
		var posCell = _tile.world_to_map(Vector2(posNeigh[i].x,posNeigh[i].y))
		if _tile.get_cellv(posCell) != -1:
			result.append(posCell)
		
	
	return result


func BreadthFS(graph_node, destination, start_node):
	var result = []
	var visited = []
	var queue = []
	
	var success = false
	queue.append(start_node)
	visited.append(start_node)
	var current_index = null
	var index_position = 0
	
	while(queue):
		current_index = queue.pop_back()
		
		
		if current_index == destination:
			success = true
			break
		
		var neighbour= graph_node[index_position][1]
		
		for i in range(neighbour.size()):
			if visited.has(neighbour[i]) == false:
				visited.append(neighbour[i])
				queue.append(neighbour[i])
		
		
		index_position = index_position + 1
	
	#uniform search
	if success == true:
		var current = current_index
		
		print(visited)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		print(_tile.world_to_map(get_viewport().get_mouse_position()))
	
	






