extends Resource

class_name Item

@export var item_name: String
@export var item_quantity: int
@export var item_description: String
@export var item_price: int
@export var item_type: String
@export var item_stack: int

func _add(num: int):
	item_quantity += num
	
func _remove(num: int):
	item_quantity -= num
	if item_quantity < 0:
		item_quantity = 0

func _getstate() -> Dictionary:
	
	return {
		"item_name":item_name,
		"item_type":item_type,
		"item_quantity":item_quantity,
		"item_description":item_description,
		"item_price":item_price,
		"item_stack":item_stack
	}

func unstackable():
	item_stack = 1
