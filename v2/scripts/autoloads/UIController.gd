extends Node

signal build_batiment
signal build_path
signal start_building(building:Building)



func emit_build_batiment():
	build_batiment.emit()

func emit_build_path():
	build_path.emit()

func emit_start_building(building:Building):
	start_building.emit(building)
	
