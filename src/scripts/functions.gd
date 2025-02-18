##通用函数类
class_name Functions

##取整
static func _round(num : float, format : int = 0) -> int:
	num *= pow(10, format)
	num = roundi(num)
	num *= pow(10, -format)
	return num

##从目标地址加载json文件，返回json
static func _loadJSON(file_path : String) -> JSON:
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
	var weightSum = 0
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

##钓鱼，返回渔获列表
static func _fishing(time: int, location: Seaarea, boat: Boat) -> Array:
	var catch = []
	return catch
