extends Node2D

var seaarea = Seaarea.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print(seaarea._getstate())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fishing_pressed() -> void:
	print(Functions._fishing(30, seaarea))
	pass # Replace with function body.


func _on_sell_pressed() -> void:
	pass # Replace with function body.
