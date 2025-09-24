class_name BuildingScience
extends Building

var building_type = BUILDING_TYPE.SCIENCE

@export var producing: bool 	# whether the building is producing science atm

@export var science_per_second: float:		# per scientist
	set(value):
		science_per_second = clamp(value, 0, max_science_per_second)
@export var max_science_per_second: int

# minimum number of scientists to start producing science
@export var min_scientists: int: 	
	set(value):
		min_scientists = value if (min_scientists + value > 0) else 0
@export var current_cap: int:		# upgradable number of scientists in the building
	set(value):
		current_cap = current_cap + value if (current_cap + value < max_scientists) else max_scientists
@export var max_scientists: int		# admin fixed number of scientists in the building

func change_sci_min(n: int):
	min_scientists = n

func upgrade_scientists_cap(upgrade: int):
	current_cap += upgrade
