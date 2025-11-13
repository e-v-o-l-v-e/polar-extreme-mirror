extends Node

signal build_batiment(bname : Enums.BUILDING_NAME)
signal build_path
signal start_building(building:Building)

signal validate_building_placement(building:Building)

func emit_build_batiment(bname : Enums.BUILDING_NAME):
	build_batiment.emit(bname)

func emit_build_path():
	build_path.emit()

func emit_start_building(building:Building):
	start_building.emit(building)
	
func emit_validate_building_placement(building:Building):
	validate_building_placement.emit(building)
	
