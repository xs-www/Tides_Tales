##通用函数类
class_name Functions

##取整
static func _round(num : float, format : int = 0) -> float:
	num *= pow(10, format)
	num = roundi(num)
	num *= pow(10, -format)
	return num

##从目标地址加载json文件，返回json
static func _loadJSON(file_path : String):
	var json_file = FileAccess.open(file_path, FileAccess.READ)
	var file_text = json_file.get_as_text()
	var json = JSON.parse_string((file_text))
	json_file.close()
	return json

##获取当前本地时间
static func _get_time() -> String:
	var time : Dictionary = Time.get_datetime_dict_from_system()
	return "%04d%02d%02d-%02d:%02d:%02d" % [time['year'], time['month'], time['day'], time['hour'], time['minute'], time['second']]

##生成随机颜色
static func _randomColor() -> Color:
	var c = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
	return c

##从列表中随机挑选元素
static func _randomChoice(list : Array):
	var idx = randi_range(0, len(list) - 1)
	return list[idx]

##从列表1中按照列表2的概率随机挑选元素
static func _randomChoiceWithChance(list : Array, chance_list : Array):
	var p = randf_range(0, 1)
	var idx = -1
	while p >= 0:
		idx += 1
		p -= chance_list[idx]
	return list[idx]

##从列表1中按照列表2的权重随机挑选元素
static func _randomChoiceWithWeight(list : Array, weight_list : Array):
	var weightSum = 0.0
	for w in weight_list:
		weightSum += w
	var chance_list = []
	for i in range(len(weight_list) - 1):
		chance_list.append(weight_list[i]/weightSum)
	chance_list.append(weight_list[len(weight_list) - 1]/weightSum)
	return _randomChoiceWithChance(list, chance_list)

##生成基于minn--maxn区间上的正态分布的伪随机数
static func _randfn_range(minn: float, maxn: float) -> float:
	var mean = (minn + maxn)/2
	var delta = maxn - mean
	var num = RandomNumberGenerator.new().randfn(mean, delta/2)
	while abs(num - mean) >= delta:
		num = RandomNumberGenerator.new().randfn(mean, delta/2)
	return num
	
##
static func _sum(list: Array) -> float:
	var sum = 0.0
	for i in list:
		sum += i
	return sum

##
static func _addIntoDictionary(key: String, val: Variant, dic: Dictionary):
	if key in dic:
		dic[key] += val
	else:
		dic[key] = val
	return dic


##钓鱼，返回渔获列表
static func _fishing(time: int, sea_area: Seaarea, boat: Boat) -> Dictionary:
	var catchinfo = {}
	var maximun_weight = boat.boat_capability
	var catch_p = boat._fishsuccess(sea_area)
	var current_weight = 0
	for i in range(1, time * 60):
		if randf() < catch_p:
			var fishinfo = sea_area._getfishinfo()
			if _sum(fishinfo["fishpopu"]) == 0:
				break
			var caughtfish = Functions._randomChoiceWithWeight(fishinfo["fishlist"], fishinfo["fishpopu"])
			sea_area._setfishquantity(caughtfish, -1)
			_addIntoDictionary(caughtfish, [i], catchinfo)
	var dic = {}
	for fishtype in catchinfo:
		dic[fishtype] = len(catchinfo[fishtype])
	return dic
