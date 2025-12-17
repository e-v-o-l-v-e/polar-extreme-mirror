extends Node2D

@onready var world_grid: WorldGrid = %WorldGrid
@onready var path: Path = $PathRegions/Path
@onready var scientist_manager : ScientistManager = load("res://scripts/systems/ScientistManager.gd").new()

func _ready():
	GameController.set_grid(%WorldGrid)
	world_grid.scientist_spawn_position.global_position = path.global_position
	var defaultBedRoom = load("res://scenes/buildings/instanciables/Bedroom.tscn").instantiate()
	var mouse_pos_glob: Vector2 = Vector2(1000,560)
	var mouse_pos_grid: Vector2 = to_local(mouse_pos_glob)
	var tile_under_mouse: Vector2i = world_grid.local_to_map(mouse_pos_grid)
	var world_grid_pos: Vector2 = world_grid.map_to_local(tile_under_mouse)
	defaultBedRoom.position = world_grid_pos
	UiController.emit_validate_building_placement(defaultBedRoom)
	var defaultScience = load("res://scenes/buildings/instanciables/LabGlaciology.tscn").instantiate()
	mouse_pos_glob = Vector2(850,520)
	mouse_pos_grid = to_local(mouse_pos_glob)
	tile_under_mouse = world_grid.local_to_map(mouse_pos_grid)
	world_grid_pos = world_grid.map_to_local(tile_under_mouse)
	defaultScience.position = world_grid_pos
	UiController.emit_validate_building_placement(defaultScience)
	UiController.emit_enroll_scientist()
