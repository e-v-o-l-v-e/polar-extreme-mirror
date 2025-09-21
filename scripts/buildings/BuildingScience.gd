class_name BuildingScience
extends Building

var building_type = BUILDING_TYPE.SCIENCE

# science var
@export var producing: bool 	# whether the building is producing science atm
@export var science_per_second: int
@export var max_science_per_second: int
