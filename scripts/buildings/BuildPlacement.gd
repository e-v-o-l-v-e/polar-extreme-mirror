extends TileMapLayer
class_name BuildPlacement

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var preview: Sprite2D = $PreviewSprite

@export var effect_size: Vector2 = Vector2(3, 3)

var in_placement: bool = false
var can_be_placed: bool = true
var building_data: Building

var placement_position: Vector2
var cell_array: Array[Vector2i] = []


func _input(event: InputEvent) -> void:
	_update_mouse_positions()
	_handle_hotkeys()
	if in_placement:
		_handle_rotation_input()
		_handle_placement_preview(event)
		_handle_building_click(event)



func start_building(building: Building) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	in_placement = true
	building_data = building

	var sprite_node: Sprite2D = building.get_node_or_null("Sprite2D")
	if sprite_node:
		preview.texture = sprite_node.texture

	var building_zone: CollisionShape2D = building.get_node_or_null("BuildingZone")
	if building_zone:
		effect_size = building_zone.shape.get_rect().size / 32

func stop_building() -> void:
	in_placement = false
	building_data = null
	preview.texture = null



func _handle_hotkeys() -> void:
	if Input.is_key_pressed(KEY_H):
		start_building(load("res://scenes/buildings/instanciables/IceMine.tscn").instantiate())
	elif Input.is_key_pressed(KEY_J):
		start_building(load("res://scenes/buildings/instanciables/Toilet.tscn").instantiate())



func _update_mouse_positions() -> void:
	var mouse_pos_glob: Vector2 = get_global_mouse_position()
	var mouse_pos_grid: Vector2 = to_local(mouse_pos_glob)
	var tile_under_mouse: Vector2i = local_to_map(mouse_pos_grid)
	var world_grid_pos: Vector2 = map_to_local(tile_under_mouse)

	preview.position = world_grid_pos

func _handle_rotation_input() -> void:
	if Input.is_key_pressed(KEY_R):
		preview.rotate(PI / 2)

func _handle_placement_preview(event: InputEvent) -> void:
	_clear_previous_preview()
	can_be_placed = true

	var tile_under_mouse: Vector2i = local_to_map(to_local(get_global_mouse_position()))
	var size = effect_size

	for i in range(-size.x / 2, size.x / 2 + 1):
		for j in range(-size.y / 2, size.y / 2 + 1):
			var pos: Vector2i = tile_under_mouse + Vector2i(i, j)
			cell_array.append(pos)
			var cell_world_pos: Vector2 = map_to_local(pos)
			if _cell_collides(cell_world_pos):
				set_cell(pos, 0, Vector2i(1, 0))
				can_be_placed = false
			else:
				set_cell(pos, 0, Vector2i(2, 0))

func _handle_building_click(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		placement_position = preview.position
		animation.play("placementAnimationLib/goodPlacement")

func _clear_previous_preview() -> void:
	for cell_pos in cell_array:
		set_cell(cell_pos, 0, Vector2i(0, 0))
	cell_array.clear()



func _place_building(_anim_name: StringName) -> void:
	if not can_be_placed:
		return

	var instance: Building = building_data
	instance.rotation = preview.rotation
	instance.position = placement_position
	instance.name = instance.name + "_" + str(building_data.get_id())
	
	print(instance.name)
	%WorldGrid.add_child(instance)
	BuildingsInfo.add_building(instance)
	stop_building()



func _cell_collides(cell_world_pos: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var cell_size = tile_set.tile_size

	var rect_shape = RectangleShape2D.new()
	rect_shape.size = cell_size

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = rect_shape
	query.transform = Transform2D(0, cell_world_pos)
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.exclude = [self]

	var result = space_state.intersect_shape(query, 1)
	return result.size() > 0
