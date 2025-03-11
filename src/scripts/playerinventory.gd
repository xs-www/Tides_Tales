extends Resource

##玩家库存
class_name PlayerInventory

##物品
@export var items : Dictionary
##金钱
@export var money : int

##初始化
func _init() -> void:
	
	items = {
		"fishes" : [],
		"boats" : [],
		"fishnets": []
	}
	money = 1000

##获取库存状态
func _getstate() -> Dictionary:
	
	var itemstates = {}
	
	for itype in items:
		var iteml = []
		for i in items[itype]:
			iteml.append(i._getstatesimply())
		itemstates[itype] = iteml
		
	return {
		"items": itemstates,
		"money": money
	}

##加入鱼获
func _addfish(fish_dic : Dictionary) -> void:
	for eachf in fish_dic:
		var newfish = FishItem.new(eachf)
		newfish._add(fish_dic[eachf])
		_add_item(newfish)
		
##卖出物品
func _sell(item: Item, quantity: int = 1):
	if quantity > item.item_quantity:
		print("没这么多")
	else:
		item._remove(quantity)
		money += item.item_price * quantity
		print("卖出 ", item.item_name, " 条", quantity, ",获得 ", item.item_price * quantity, " money")

##添加物品
func _add_item(item: Item):
	var aim_item_type_list = items[item.item_type]
	for origin_item in aim_item_type_list:
		if origin_item.item_name == item.item_name:
			origin_item._combine(item)
	if item.item_quantity > 0:
		aim_item_type_list.append(item)
		item.connect("quantity_depleted", _on_item_depleted)  # 监听信号

##当某物品用光时移除
func _on_item_depleted(item: Item):
	items[item.item_type].erase(item)  # 从库存列表中删除
