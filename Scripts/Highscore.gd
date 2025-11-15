extends Node
@export var container: VBoxContainer
@export var HighScorePath :String="user://highscores.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if container==null:
		return
	var highscores=Deserialize()
	for highscore in highscores:
		var lable :Label
		lable=Label.new()
		lable.text=str(highscore)+": "+str(highscores[highscore])
		lable.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lable.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		container.add_child(lable)
	pass

func sort_dict_by_value(input_dict: Dictionary) -> Dictionary:
	var keys = input_dict.keys()
	# Sort keys by their corresponding values (descending order - highest first)
	keys.sort_custom(func(a, b): return input_dict[a] > input_dict[b])

	var sorted_dict = {}
	for key in keys:
		sorted_dict[key] = input_dict[key]
	return sorted_dict

func Deserialize()->Dictionary:
	if not FileAccess.file_exists(HighScorePath):
		return {}
	var file: FileAccess = FileAccess.open(HighScorePath, FileAccess.READ)
	if file == null:
		return {}

	var content: String = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(content)
	if error != OK:
		return {}
	return sort_dict_by_value(json.data)

func Serialize(values:Dictionary)->void:
	#serialize as json
	var json_string: String = JSON.stringify(values)
	var file: FileAccess = FileAccess.open(HighScorePath, FileAccess.WRITE)

	if file != null:
		file.store_string(json_string)
		file.close()
	pass

func AddHighscore(player_name: String, score: int)->void:
	var highscores: Dictionary = Deserialize()
	highscores[player_name] = score
	Serialize(highscores)
	pass
