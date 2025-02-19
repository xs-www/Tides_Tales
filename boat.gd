extends Node2D

##船类
class_name Boat

@export var boat_name: String
@export var boat_capability: int
@export var fish_net: FishNet
@export var boat_durability: int
@export var boat_type: String

##
func _init(n : String = 'a boat') -> void:
	
	boat_name = n
	boat_capability = 500
	boat_durability = 100
	boat_type = 'small'
	_setfishnet()
	pass

##
func _getstate() -> Dictionary:
	
	return {
		"boat_name":boat_name,
		"boat_capability":boat_capability,
		"boat_durability":boat_durability,
		"boat_type":boat_type,
		"fish_net":fish_net._getstate()
	}

func _setfishnet(fn: FishNet = FishNet.new()) -> void:
	fish_net = fn

func _fishsuccess(sea_area: Seaarea) -> float:
	var area_coefficient = {
		'coastland': 1.0,
		'coastwater': 0.8,
		'distantwater': 0.5
	}[sea_area.area_type]
	
	var boat_bonus = {
		'small': 0.1 if sea_area.area_type == 'coastland' else 0,
		'medium': 0.1 if sea_area.area_type == 'coastwater' else 0,
		'large': 0.1 if sea_area.area_type == 'distantwater' else 0
	}[boat_type]
	
	return Functions._round(fish_net.net_probability * area_coefficient + boat_bonus, 2)
