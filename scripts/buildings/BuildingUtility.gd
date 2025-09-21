class_name BuildingUtility
extends Building

var building_type = BUILDING_TYPE.UTILITY

enum WELL_BEING_TYPE { SANITARY, REST, SOCIAL }
@export var well_being_value: int
@export var well_being_type: WELL_BEING_TYPE
