class_name BuildingFactory
extends Node

signal building_mode
signal building_select
signal building_placement

var available_buildings = []

func createLabo(pos: Vector2):
	var labo = Laboratory.new()
	labo.constructs(pos)

func createToilets(pos: Vector2):
	var toilets = Toilets.new()
	toilets.constructs(pos)
