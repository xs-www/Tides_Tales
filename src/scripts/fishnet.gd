extends Node2D

class_name FishNet

@export var net_name: String
@export var net_rank: String
@export var net_durability: int
@export var net_description: String
@export var net_probability: float

func _init(n : String = '小渔网') -> void:
	
	net_name = n
	net_rank = 'normal'
	net_durability = 100
	net_probability = 0.1

func _getstate() -> Dictionary:
	
	return {
		"net_name":net_name,
		"net_rank":net_rank,
		"net_durability":net_durability,
		"net_description":net_description,
		"net_probability":net_probability
	}
