extends Node2D

## 鱼群类
class_name FishSchool

##鱼群种类
@export var school_name: String
##鱼群数量
@export var school_population: int
##种群等级
@export var school_rank: String
##种群价格
@export var price: Array
##自然增长率
var growth_rate: float
##最大承载力
var maxmium_population: int

func _init(n : String = '小黄鱼') -> void:
	var fishinfo = Functions._loadJSON("res://src/data/fishes.json")
	school_name = n
	school_rank = fishinfo[school_name]["rank"]
	price = fishinfo[school_name]["price"]
	growth_rate = {
		"normal": 0.06,
		"rare": 0.03,
		"epic": 0.02,
		"legendary": 0.01
	}[school_rank]
	maxmium_population = {
		"normal": 1500,
		"rare": 500,
		"epic": 200,
		"legendary": 50
	}[school_rank] * randf_range(0.7, 1.3)
	school_population = randi_range(maxmium_population/4, 2*maxmium_population/3)
	
func _set_population(p: int) -> void:
	school_population = p

func _get_state() -> Dictionary:
	return {
		"school_name": school_name,
		"school_population": school_population,
		"school_rank": school_rank,
		"price": price
	}

func _naturegrow() -> void:
	
	school_population += growth_rate * school_population * (1 - (school_population / maxmium_population))
