extends Node2D


onready var half_size 
var time_before = OS.get_ticks_msec()

# Do stuff

var total_time 
 
#func _ready() -> void:
#
#	print(getPathTo())
	
	
	

#cari tetangga
func getNeighbours(_index):
	var result = []
	
	var pos = $TileMap.map_to_world(_index)
	
	
	pos.x += half_size.x
	pos.y += half_size.y
	
	result = getDataNeighbours(pos)
	
	return result

#ambil data tetangga
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
		var posCell = $TileMap.world_to_map(Vector2(posNeigh[i].x,posNeigh[i].y))
		if $TileMap.get_cellv(posCell) != -1:
			result.append(posCell)
		
	
	return result

#implement algoritma BFS 
func BreadthFS(start_index, end_index):
	
	var result = null
	
	var visited = []
	var openlist = [[start_index, null]]
	var current_index = null
	var neighbours = null
	
	var index_position = 0

	var succsess = false
	
	visited.append([start_index, null])
	
	while(index_position < openlist.size()):
		current_index = openlist[index_position]
		
		
		if current_index[0] == end_index:
			succsess = true
			break
	
		neighbours = self.getNeighbours(current_index[0])
		
		for i in range(neighbours.size()):
			if visited.has(neighbours[i]) == false:
				openlist.append([neighbours[i], index_position])
				visited.append([neighbours[i], true])
				
		index_position = index_position + 1
	
	if(succsess == true):
		
		result      = []
		var current = current_index
		
		while(current[1] != null):
			result.push_front(current[0])
			current = openlist[current[1]]
			
		total_time = OS.get_ticks_msec() - time_before
		print("Time taken: " + str(total_time))
		
		return result
	
	
func getPathTo():
	half_size = $TileMap.cell_size / 2
	var result = []
	var enemy_position  = $TileMap.world_to_map($Enemy.position)
	var player_position = $TileMap.world_to_map($Player.position)
	
	var path =  BreadthFS(enemy_position, player_position)
	
	
	for i in range(path.size()):
		var _pos_world = $TileMap.map_to_world(path[i]) + half_size
		result.append(_pos_world)
	
	return result
	
	

