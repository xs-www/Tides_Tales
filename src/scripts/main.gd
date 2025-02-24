extends Node2D

var sea_area = Seaarea.new()
var boat = Boat.new()

var player_inventory = PlayerInventory.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var f1 = FishSchool.new()
	var f2 = FishSchool.new('沙丁鱼')
	sea_area._addfishschool(f1)
	sea_area._addfishschool(f2)
	print(sea_area._getstate())
	print(boat._getstate())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fishing_pressed() -> void:
	var fished = Functions._fishing(30, sea_area, boat)
	player_inventory._addfish(fished)
	print(sea_area._getstate())
	print(player_inventory._getstate())
	pass # Replace with function body.


func _on_sell_pressed() -> void:
	pass # Replace with function body.


func _on_nextday_pressed() -> void:
	sea_area._update()
	print(sea_area._getstate())
	pass # Replace with function body.
