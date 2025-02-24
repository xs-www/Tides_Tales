extends Node2D

class_name PlayerInventory

@export var fishes : Dictionary
@export var money : int

func _init() -> void:
	
	fishes = {}
	money = 0

func _getstate() -> Dictionary:
	
	return {
		"fishes": fishes,
		"money": money
	}

func _addfish(fish_dic : Dictionary) -> void:
	
	for f in fish_dic:
		Functions._addIntoDictionary(f, fish_dic[f], fishes)

func _sell(item: Item, quantity: int = 1):
	
	pass
