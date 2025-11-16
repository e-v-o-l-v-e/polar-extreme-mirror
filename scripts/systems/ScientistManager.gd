extends Node
class_name ScientistManager

var scientist_factory : ScientistFactory = load("res://scripts/factories/ScientistFactory.gd").new()

func enroll_scientist() -> Scientist:
	return scientist_factory.make_scientist()
