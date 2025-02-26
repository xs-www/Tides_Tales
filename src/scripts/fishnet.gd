extends Item

##渔网类，继承自Item
class_name FishNet

##渔网品质
@export var net_rank: String
##渔网耐久
@export var net_durability: int
##渔网基础捕捞概率
@export var net_probability: float

##初始化渔网
func _init(_item_name : String = '小渔网') -> void:
	
	item_name = _item_name
	item_type = 'fishnets'
	item_stack = 1
	unstackable()
	var netinfo = Functions._loadJSON("res://src/data/fishnet.json")[item_name]
	net_rank = netinfo["rank"]
	net_durability = netinfo["durability"]
	net_probability = netinfo["probability"]
	item_description = netinfo["description"]

##获取渔网状态
func _getstate() -> Dictionary:
	
	var dic = super._getstate()  # 调用父类的 _getstate()
	dic["net_rank"] = net_rank
	dic["net_durability"] = net_durability
	dic["net_probability"] = net_probability
	
	return dic
