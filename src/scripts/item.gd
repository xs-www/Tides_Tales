extends Resource

##Item基类
class_name Item

##物品用完的信号
signal quantity_depleted(item: Item)

##物品名称
@export var item_name: String
##物品数量
@export var item_quantity: int
##物品描述
@export var item_description: String
##物品价格
@export var item_price: int
##物品类别
@export var item_type: String
##物品最大堆叠
@export var item_stack: int

##增加num个物品
func _add(num: int):
	item_quantity += num
	if item_quantity >= item_stack:
		item_quantity = item_stack

##移除num个物品
func _remove(num: int):
	item_quantity -= num
	if item_quantity <= 0:
		item_quantity = 0
		emit_signal("quantity_depleted", self)  # 发送信号

##移除全部物品
func _removeall():
	item_quantity = 0
	emit_signal("quantity_depleted", self)

##获得物品状态
func _getstate() -> Dictionary:
	
	return {
		"item_name":item_name,
		"item_type":item_type,
		"item_quantity":item_quantity,
		"item_description":item_description,
		"item_price":item_price,
		"item_stack":item_stack
	}

##获得物品简要状态（物品名称：数量）
func _getstatesimply() -> Dictionary:
	
	var dic = {}
	dic[item_name] = item_quantity
	return dic

##无法堆叠的
func unstackable():
	item_stack = 1

##物品结合
func _combine(another_item : Item):
	if another_item.item_name == item_name:
		_add(another_item.item_quantity)
		another_item._removeall()
	
