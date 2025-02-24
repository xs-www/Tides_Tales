extends Item

class_name FishNet

@export var net_rank: String
@export var net_durability: int
@export var net_probability: float

func _init(n : String = '小渔网') -> void:
	
	item_name = n
	item_type = 'fishnet'
	unstackable()
	var netinfo = Functions._loadJSON("res://src/data/fishnet.json")[item_name]
	net_rank = netinfo["rank"]
	net_durability = netinfo["durability"]
	net_probability = netinfo["probability"]
	item_description = netinfo["description"]

func _getstate() -> Dictionary:
	
	var dic = super._getstate()  # 调用父类的 _getstate()
	dic["net_rank"] = net_rank
	dic["net_durability"] = net_durability
	dic["net_probability"] = net_probability
	
	return dic
