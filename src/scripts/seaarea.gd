extends Node2D

##海域类
class_name Seaarea

##海域名称
@export var area_name : String
##海域描述
@export var description : String
##海域鱼群
@export var fishes : Array[FishSchool]
##海域类别
@export var area_type : String

##初始化
func _init(type : String = 'coastland') -> void:
	var name_list = Functions._loadJSON("res://src/data/seaareanames.json")
	area_name = Functions._randomChoice(name_list)
	area_type = type
	description = Functions._loadJSON("res://src/data/seaarea.json")[area_type]["description"]
	
##获取海域状态
func _getstate():
	var fishinfo = []
	for f in fishes:
		fishinfo.append(f._get_state())
	var dic = {
		"area_name":area_name,
		"description":description,
		"fishes":fishinfo,
		"type":area_type
	}
	
	return dic

##添加鱼群
func _addfishschool(fish: FishSchool):
	var same_school = null
	for f in fishes:
		if f.school_name == fish.school_name:
			same_school = f
			break
	if same_school:
		same_school.school_population += fish.school_population
	else:
		fishes.append(fish)

##获得海域内鱼群信息
func _getfishinfo() -> Dictionary:
	
	var fishlist = []
	var fishpopu = []
	for f in fishes:
		fishlist.append(f.school_name)
		fishpopu.append(f.school_population)
	
	return {
		"fishlist":fishlist,
		"fishpopu":fishpopu
	}

##增减鱼群数量
func _setfishquantity(fn: String, delta: int) -> void:
	
	for f in fishes:
		if f.school_name == fn:
			f.school_population += delta
		if f.school_population < 0:
			f.school_population = 0
			break

##按天更新海域
func _update():
	
	for f in fishes:
		f._naturegrow()

##生成随机鱼群
func _genfishschool():
	
	
	pass
