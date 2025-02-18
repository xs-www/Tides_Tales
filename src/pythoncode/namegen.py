import json

# 定义文件名列表
file_names = [f'D:\GodotGame\渔舟唱晚\src\pythoncode\city_name_generator ({i}).txt' for i in range(12)]

existing_json_file = 'D:\GodotGame\渔舟唱晚\merged_cities_unique.json'

# 加载已有的 JSON 数据
try:
    with open(existing_json_file, 'r', encoding='utf-8') as json_file:
        existing_cities = set(json.load(json_file))
except FileNotFoundError:
    existing_cities = set()

# 整合新旧数据
updated_cities = existing_cities.copy()

# 遍历每个文件
for file_name in file_names:
    try:
        with open(file_name, 'r', encoding='utf-8') as file:
            lines = file.readlines()
            # 遍历每一行
            for line in lines:
                # 去除行尾的换行符和空白字符
                city = line.strip()
                # 剔除包含空格、空行和重复的城市名
                if city and ' ' not in city and 'field' not in city:
                    updated_cities.add(city)
    except FileNotFoundError:
        print(f"文件 {file_name} 未找到，跳过...")

# 将集合转换为列表并存为JSON文件
output_file = 'merged_cities_unique1.json'
with open(output_file, 'w', encoding='utf-8') as json_file:
    json.dump(list(updated_cities), json_file, ensure_ascii=False, indent=4)

print(f"全部城市名已合并到 {output_file} 中，并且空格以及重复名称都已过滤。")