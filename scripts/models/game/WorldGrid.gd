extends TileMapLayer
class_name WorldGrid

@onready var scientist_spawn_position: Marker2D = $ScientistSpawnPosition
@onready var scientist_container = $ScientistContainer
@onready var building_container = $BuildingContainer

var buildings_doors_positions = {
	Enums.BUILDING_TYPE.LABORATORY_GLACIOLOGY : [],
	Enums.BUILDING_TYPE.LABORATORY_ATMOSPHERIC_PHYSICS : [],
	Enums.BUILDING_TYPE.LABORATORY_MAGNETISM_SEISMOLOGY : [],
	Enums.BUILDING_TYPE.LABORATORY_HUMAN_BIOLOGY : [],
	Enums.BUILDING_TYPE.ICEMINE : [],
	Enums.BUILDING_TYPE.GREENHOUSE : [],
	Enums.BUILDING_TYPE.DORMITORY : [],
	Enums.BUILDING_TYPE.CANTEEN : [],
	Enums.BUILDING_TYPE.SHOWER : [],
	Enums.BUILDING_TYPE.TOILET : [],
	Enums.BUILDING_TYPE.LOUNGE : [],
	Enums.BUILDING_TYPE.GYM : [],
	Enums.BUILDING_TYPE.WASTE_SORTING : [],
	Enums.BUILDING_TYPE.WATER_RECYCLING : [],
	Enums.BUILDING_TYPE.POWER_PLANT : [],
}

func register_door_position(building : Building):
	buildings_doors_positions[building.get_building_type()].append(building.global_position)

func get_scientist_spawn_position() -> Vector2:
	return scientist_spawn_position.global_position

func add_scientist(scientist_scene : Scientist) :
	scientist_scene.global_position = scientist_spawn_position.global_position
	scientist_container.add_child(scientist_scene)

func add_building(building_scene : Building):
	register_door_position(building_scene)
	building_container.add_child(building_scene)
