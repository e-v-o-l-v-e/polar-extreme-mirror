extends Node
class_name BuildingManager

static var building_descriptions = [
	"Bâtiment aux parois blanches et aux surfaces ultra-propres. Ici, les carottes de glace, archives du climat terrestre, sont analysées. Ce cœur scientifique décrypte l'histoire du climat sur des centaines de milliers d'années.",
	"Couronné d'instruments de mesure et d'antennes. Il étudie la composition de l'air, le trou dans la couche d'ozone et les rayonnements cosmiques dans l'un des airs les plus purs de la planète.",
	"Une structure isolée, sans métal, souvent enterrée. Il enregistre les plus infimes vibrations de la Terre et les variations du champ magnétique, loin du bruit humain",
	"Équipé de matériel médical et physiologique de pointe. Il est dédié à l'étude de l'adaptation du corps humain à l'isolement, au froid extrême et aux cycles de lumière polaires.",
	"Un puits ou une cave foré dans la glace millénaire. Cet entrepôt naturel à -50°C préserve les précieuses carottes de glace avant leur analyse et fournit de l'eau de fonte 'pure' pour les expériences",
	"Une bulle de vie et de chlorophylle sous lumière artificielle. Cette unité de production hydroponique fournit des légumes frais et améliore le moral par sa simple présence",
	"Des cellules individuelles minimalistes mais personnalisables. Sanctuaires privés essentiels pour le repos et la préservation de l'intimité dans un environnement collectif intense.",
	"Cœur chaleureux et odorant de la station. Lieu de transformation des vivres et de création culinaire, c'est un espace de travail partagé et de convivialité informelle",
	"Espace limité où l'eau est un luxe comptabilisé. Les sessions sont courtes et régulées, faisant de ce moment une routine précieuse.",
	"Installations sanitaires basiques mais essentielles. Conçues pour un usage économe en eau et un traitement séparé des déchets solides et liquides.",
	"Espace convivial avec canapés, jeux, musique et films. Dédié au divertissement et à la déconnexion, loin des laboratoires et des écrans de travail.",
	"Équipée de vélos, tapis de course et poids. Indispensable pour lutter contre l'atrophie musculaire et la baisse de moral induites par le confinement et le froid.",
	"Salle technique stricte avec des bacs de couleurs. Chaque type de déchet (organique, plastique, métal, dangereux) y est scrupuleusement séparé pour un traitement adapté.",
	"Unité de traitement technique et vitale. Elle transforme toutes les eaux usées (douches, lavabos, cuisines) en eau pure pour être réutilisée, souvent pour les toilettes ou les labos.",
	"Le battement de cœur bruyant et chaud de la base. Abritant les générateurs, c'est la source d'énergie pour la chaleur, la lumière, la science et la communication."
]

var building_factory = load("res://scripts/factories/BuildingFactory.gd").new()
var path_factory = load("res://scripts/factories/PathFactory.gd").new()
var buildingsIds := {}

var building_counter := 0
var hovered_building : Building = null

var buildings_list : Array[Building]= []
var buildings_positions := []

func create_building(btype : Enums.BUILDING_TYPE) -> Building:
	var building : Building = building_factory.create_building(btype)
	building.name = "Building" + str(building_counter)
	
	var plist = GameController.get_projects_manager().get_list(btype, building)
	if plist and building.has_method("set_projects"):
		building.set_projects(plist)
		print("ajoute la liste")
		print(str(btype) + building.name)
		print("\n")
		
	return building

func create_path() -> Path:
	var path = path_factory.create_path()
	return path

func register(building : Building):
	building_counter += 1
	var type = building.get_building_type()
	buildings_positions.append(building.get_door_position())
	buildings_list.append(building)
	
func unregister(building:Building):
	var type = building.get_building_type()
	buildings_positions[type].erase(building)
	
func get_building(id :int) -> Building:
	return buildingsIds[id]

func get_random_building_position() -> Vector2:
	if buildings_positions.size() != 0:
		return buildings_positions.pick_random()
	else :
		return Vector2(0,0)
		
func get_building_description(btype : Enums.BUILDING_TYPE) -> String :
	return building_descriptions[btype]
	#var key = buildings_positions.keys().pick_random()
	#return buildings_positions[key].pick_random()
