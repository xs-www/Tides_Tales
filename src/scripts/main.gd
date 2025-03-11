extends Node2D

var sea_area = Seaarea.new()
var boat = Boat.new()
var fish_net = FishNet.new()

var player_inventory = PlayerInventory.new()

#var seaarea_manager = SeaareaManager.new(5, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Functions._gen_saving_fishinfo('aaa')
	
	#seaarea_manager._generate_map()
	#print(seaarea_manager.seaareas)
	sea_area._gen_fishschool("res://src/saves/001.json")
	
	
	#var f1 = FishSchool.new()
	#var f2 = FishSchool.new('黄带比目鱼')
	#sea_area._add_fish_school(f1)
	#sea_area._add_fish_school(f2)
	player_inventory._add_item(boat)
	player_inventory._add_item(fish_net)
	boat._setfishnet(fish_net)
	
	print(sea_area._getstate())
	print(sea_area._get_fish_population())
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fishing_pressed() -> void:
	var fished = Functions._fishing(30, sea_area, boat)
	print(fished)
	player_inventory._addfish(fished)
	print(sea_area._getstate())
	print(player_inventory._getstate())
	pass # Replace with function body.


func _on_sell_pressed() -> void:
	while len(player_inventory.items["fishes"]) > 0:
		var f = player_inventory.items["fishes"][0]
		player_inventory._sell(f, f.item_quantity)
	print(player_inventory._getstate())


func _on_nextday_pressed() -> void:
	sea_area._update()
	print(sea_area._getstate())
	pass # Replace with function body.
	
