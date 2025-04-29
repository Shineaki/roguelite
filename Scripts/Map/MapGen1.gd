extends Node

var floor: TileMapLayer = null
var walls: TileMapLayer = null

func path_finding() -> void:
	var astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2i(0, 0, 32, 32)
	astar_grid.cell_size = Vector2(16, 16)
	astar_grid.update()
	print(astar_grid.get_id_path(Vector2i(0, 0), Vector2i(3, 4)))


func _ready() -> void:
	floor = get_node("Floor")
	walls = get_node("Walls")
	
	var wall_array = []
	for i in range(-5, 6):
		for j in range(-5, 6):
			if abs(i) < 5 and abs(j) < 5:
				floor.set_cell(Vector2(i, j), 0, Vector2(0, 0))
				if i == 4:
					wall_array.append(Vector2(i, j))
			else:
				if i > 4:
					continue
				wall_array.append(Vector2(i, j))
	walls.set_cells_terrain_connect(wall_array, 0, 0)
