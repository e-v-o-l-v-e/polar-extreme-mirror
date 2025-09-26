class_name BuildingScience
extends Building

@export var building_type = BUILDING_TYPE.SCIENCE

@export var producing: bool 	# whether the building is producing science atm

@export var science_per_second: float:		# per scientist
	set(value):
		science_per_second = clamp(value, 0, max_science_per_second)
@export var max_science_per_second: int

# minimum number of scientists to start producing science
@export var nb_scientists: int:
	set(value):
		nb_scientists = clamp(value, 0, nb_scientists_min)

@export var nb_scientists_min: int: 	
	set(value):
		nb_scientists_min = value if (nb_scientists_min + value > 1) else 1

func change_min_scientists(n: int):
	nb_scientists_min += n
