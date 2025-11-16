extends Node
class_name ScientistFactory

const SCIENTIST_PATH = "res://scenes/scientist/Scientist.tscn"

func make_scientist() -> Scientist :
	var scene = load(SCIENTIST_PATH).instantiate()
	return scene
