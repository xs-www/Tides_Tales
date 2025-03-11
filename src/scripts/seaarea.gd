extends Node2D

##海域类
class_name Seaarea

##海域名称
@export var area_name : String
##海域描述
@export var description : String
##海域鱼群
@export var fish_schools : Array[FishSchool]
##海域类别
@export var area_type : String
##
@export var maximum_capacity : int
##邻接海域
var neighbours : Array

##初始化
func _init(type : String = 'coastland') -> void:
	var name_list = Functions._loadJSON("res://src/data/seaareanames.json")
	area_name = Functions._randomChoice(name_list)
	area_type = type
	var area_info = Functions._loadJSON("res://src/data/seaarea.json")[area_type]
	description = area_info["description"]
	maximum_capacity = area_info["maximum_capacity"]
	
##获取海域状态
func _getstate():
	var fishinfo = []
	for f in fish_schools:
		fishinfo.append(f._get_state())
	var dic = {
		"area_name":area_name,
		"description":description,
		"maximum_capacity": maximum_capacity,
		"fishes":fishinfo,
		"type":area_type
	}
	
	return dic

##添加鱼群
func _add_fish_school(fish: FishSchool):
	var same_school = null
	for f in fish_schools:
		if f.school_name == fish.school_name:
			same_school = f
			break
	if same_school:
		same_school.school_population += fish.school_population
		same_school.maximum_population += fish.maximum_population / 2
	else:
		fish_schools.append(fish)
		fish.connect("school_depleted", _on_school_depleted)

##
func _remove_fish_school():
	
	
	pass

##获得海域内鱼群信息
func _get_fish_info() -> Dictionary:
	
	var fishlist = []
	var fishpopu = []
	for f in fish_schools:
		fishlist.append(f.school_name)
		fishpopu.append(f.school_population)
	
	return {
		"fishlist":fishlist,
		"fishpopu":fishpopu
	}
	
func _get_fish_population() -> int:
	
	var tot_pop = 0
	for p in _get_fish_info()["fishpopu"]:
		tot_pop += p
	return tot_pop

##增减鱼群数量
func _set_fish_quantity(fn: String, delta: int) -> void:
	
	for f in fish_schools:
		if f.school_name == fn:
			f.school_population += delta
		if f.school_population <= 0:
			f.school_population = 0
			f.emit_signal("school_depleted", f)
			break

##按天更新海域
func _update():
	
	for f in fish_schools:
		f._naturegrow()

##生成随机鱼群
func _gen_fishschool(file_path: String = ''):
	
	var fish_info = Functions._loadJSON(file_path)
	var fish_name_list = fish_info.keys()
	var fish_weight_list = []
	for f in fish_name_list:
		var fish_dic = fish_info[f]
		fish_weight_list.append(fish_dic["coefficient"][area_type] * fish_dic["weight"])
	
	while _get_fish_population() < maximum_capacity / 2:
		var new_fish_name = Functions._randomChoiceWithWeight(fish_name_list, fish_weight_list)
		var new_fish_school = FishSchool.new(new_fish_name)
		_add_fish_school(new_fish_school)
	

##
func _on_school_depleted(fish_school: FishSchool):
	
	fish_schools.erase(fish_school)
	
