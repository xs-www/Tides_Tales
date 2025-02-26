extends Item

##渔船类，继承自Item
class_name Boat

##渔船容量
@export var boat_capability: int
##装配的渔网
@export var fish_net: FishNet
##渔船耐久
@export var boat_durability: int
##渔船类别
@export var boat_type: String

##初始化渔网
func _init(_item_name : String = 'a boat') -> void:
	
	item_name = _item_name
	item_type = 'boats'
	item_stack = 1
	item_quantity = 1
	boat_capability = 500
	boat_durability = 100
	boat_type = 'small'
	_setfishnet()
	pass

##获取渔网状态
func _getstate() -> Dictionary:
	
	var dic = super._getstate()  # 调用父类的 _getstate()
	
	dic["boat_capability"] = boat_capability
	dic["boat_durability"] = boat_durability
	dic["boat_type"] = boat_type
	dic["fish_net"] = fish_net._getstate()
	
	return dic

##获取渔网简略状态（物品名称：耐久）
func _getstatesimply() -> Dictionary:
	
	var dic = {}
	
	dic[item_name] = str(boat_durability) + "%"
	
	return dic

##设置渔网
func _setfishnet(fn: FishNet = FishNet.new()) -> void:
	fish_net = fn

##计算捕鱼成功率
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
