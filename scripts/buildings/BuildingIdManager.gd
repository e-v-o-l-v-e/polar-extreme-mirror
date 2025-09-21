class_name BuildingIdManager
extends Node

static var _next_id := 1
static var _buildings := {}

static func register(new_building):
	var id = _next_id
	_next_id += 1
	_buildings[id] = new_building
	return id

static func remove(id: int):
	_buildings.erase(id)
	
static func get_building(id: int):
	return _buildings[id]
