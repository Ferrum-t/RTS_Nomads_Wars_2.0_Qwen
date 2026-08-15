extends Node
## BuildingManager - Autoload singleton для управления зданиями
## НЕ объявляем class_name, так как это синглтон

var town_centers: Array = []
var buildings: Array = []

func _ready():
	pass

func register_town_center(tc):
	if not town_centers.has(tc):
		town_centers.append(tc)

func unregister_town_center(tc):
	town_centers.erase(tc)

func register_building(b):
	if not buildings.has(b):
		buildings.append(b)

func unregister_building(b):
	buildings.erase(b)

func get_nearest_town_center(pos: Vector3) -> Node3D:
	if town_centers.is_empty():
		return null
	
	var nearest = null
	var min_dist = INF
	
	for tc in town_centers:
		var dist = tc.global_position.distance_to(pos)
		if dist < min_dist:
			min_dist = dist
			nearest = tc
	
	return nearest
