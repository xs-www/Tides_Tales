extends Node

## 鱼群类
class_name FishSchool

##鱼群种类
@export var school_name: String
##鱼群数量
@export var school_population: int

func _init(n : String = '') -> void:
	if n == '':
		pass
	pass
