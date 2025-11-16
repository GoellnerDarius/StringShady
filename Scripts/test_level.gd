extends Node2D

const HUMAN_SCALE = Vector2(0.7, 0.7)

@export var stringSpriteUI : Array[Texture2D]
@export var stringSprite : Array[Texture2D]
@export var humanSprite0 : Array[Texture2D] 
@export var humanSprite1 : Array[Texture2D] 
@export var humanSprite2 : Array[Texture2D] 
@export var humanSprite3 : Array[Texture2D] 
@export var humanSprite4 : Array[Texture2D] 
@export var humanSprite5 : Array[Texture2D] 
@export var humanSprite6 : Array[Texture2D] 
@export var humanSprite7 : Array[Texture2D] 
@export var humanSprite8 : Array[Texture2D] 
@export var humanSprite9 : Array[Texture2D] 
@export var humanSprite10 : Array[Texture2D] 
@export var humanSprite11 : Array[Texture2D] 
@export var humanSprite12 : Array[Texture2D] 
@export var humanSprite13 : Array[Texture2D] 
@export var humanSprite14 : Array[Texture2D] 
@export var humanSprite15 : Array[Texture2D] 
@export var humanSprite16 : Array[Texture2D] 
@export var humanSprite17 : Array[Texture2D] 
@export var humanSprite18 : Array[Texture2D] 
@export var humanSprite19 : Array[Texture2D] 
@export var humanSprite20 : Array[Texture2D] 
@export var humanSprite21 : Array[Texture2D] 
@export var humanSprite22 : Array[Texture2D] 
@export var humanSprite23 : Array[Texture2D] 
@export var humanSprite24 : Array[Texture2D] 
@export var humanSprite25 : Array[Texture2D]
@export var humanSprite26 : Array[Texture2D]
@export var humanSprite27 : Array[Texture2D]
@export var humanSprite28 : Array[Texture2D] 
@export var humanSprite29 : Array[Texture2D] 
@export var humanSprite30 : Array[Texture2D] 
@export var humanSprite31 : Array[Texture2D] 
@export var humanSprite32 : Array[Texture2D] 
@export var humanSprite33 : Array[Texture2D] 
@export var humanSprite34 : Array[Texture2D] 
@export var humanSprite35 : Array[Texture2D] 
@export var humanSprite36 : Array[Texture2D] 
@export var humanSprite37 : Array[Texture2D] 
@export var humanSprite38 : Array[Texture2D] 
@export var humanSprite39 : Array[Texture2D]
@export var humanSprite40 : Array[Texture2D]
@export var humanSprite41 : Array[Texture2D]
@export var humanSprite42 : Array[Texture2D] 
@export var humanSprite43 : Array[Texture2D] 
@export var humanSprite44 : Array[Texture2D] 
@export var humanSprite45 : Array[Texture2D] 
@export var humanSprite46 : Array[Texture2D]
@export var humanSprite47 : Array[Texture2D]
@export var humanSprite48 : Array[Texture2D]

@export var HumanSpawnPoints: Array[Control]
@export var stringPoints: Array[TextureRect]

@export var stringButton:Array[Control]
@onready var animationPlayer:AnimationPlayer = $AnimationPlayer
@onready var humanSprite = [
humanSprite0,humanSprite1,humanSprite2,humanSprite3,humanSprite4,humanSprite5,humanSprite6,humanSprite7,humanSprite8
,humanSprite9,humanSprite10,humanSprite11,humanSprite12,humanSprite13,humanSprite14,humanSprite15,humanSprite16,humanSprite17,humanSprite18
,humanSprite19,humanSprite20,humanSprite21,humanSprite22,humanSprite23,humanSprite24,humanSprite25,humanSprite26,humanSprite27,humanSprite28
,humanSprite29,humanSprite30,humanSprite31,humanSprite32,humanSprite33,humanSprite34,humanSprite35,humanSprite36,humanSprite37
,humanSprite38,humanSprite39,humanSprite40,humanSprite41,humanSprite42,humanSprite43,humanSprite44,humanSprite45,humanSprite46,humanSprite47
] 
var currentUnderware:int
var nextUnderWare:int
var underwareHuman_map : Array[int]
var underwareHumanConst :Array[int]
var ManOrWoman :Array[bool]

var current_wave: int = 1
var starting_humans: int = 3
var max_waves: int = 5

@export var min_human_time: float = 10.0
@export var max_human_time: float = 20.0
var human_timers: Array[Timer]
var human_initial_times: Array[float]
var human_brown_overlays: Array[TextureRect]
var human_burnt_overlays: Array[TextureRect]


func _ready():
	Globals.score=0
	Globals.lifes=3
	StartWave()

func _process(delta: float) -> void:
	# Update brown/burnt overlays based on timer progress
	for i in range(human_timers.size()):
		if human_timers[i].is_stopped():
			continue

		var initial_time = human_initial_times[i]
		var time_left = human_timers[i].time_left
		var elapsed = initial_time - time_left
		var progress = elapsed / initial_time  # 0.0 to 1.0

		# First half: brown fades in (0% to 100%)
		if progress <= 0.5:
			var brown_alpha = progress * 2.0  # 0.0 to 1.0 during first half
			human_brown_overlays[i].modulate.a = brown_alpha
			human_burnt_overlays[i].modulate.a = 0.0
		# Second half: burnt fades in (0% to 100%), brown stays at 100%
		else:
			human_brown_overlays[i].modulate.a = 1.0
			var burnt_alpha = (progress - 0.5) * 2.0  # 0.0 to 1.0 during second half
			human_burnt_overlays[i].modulate.a = burnt_alpha

func StartWave():
	var humans_to_spawn = starting_humans + (current_wave - 1)
	ClearRound()
	Spawnhumans(humans_to_spawn)
	SpawnUnderWare(FindAnUnderWare())
	
	
func Spawnhumans(Amount):
	for n in Amount:
		var randomnumber: int = randi_range(0,humanSprite.size()-1)
		var child: TextureButton =  HumanSpawnPoints[n].get_child(0)
		child.texture_normal = humanSprite[randomnumber][0]
		HumanSpawnPoints[n].scale = HUMAN_SCALE
		underwareHuman_map.append(randomnumber % 7)
		underwareHumanConst.append(randomnumber % 7)
		if randomnumber > 20:
			ManOrWoman.append(true)
		else:
			ManOrWoman.append(false)

		# Create brown overlay (starts fully transparent)
		var brown_overlay = TextureRect.new()
		brown_overlay.texture = humanSprite[randomnumber][1]
		brown_overlay.modulate.a = 0.0
		brown_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
		brown_overlay.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		child.add_child(brown_overlay)
		brown_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		human_brown_overlays.append(brown_overlay)

		# Create burnt overlay (starts fully transparent)
		var burnt_overlay = TextureRect.new()
		burnt_overlay.texture = humanSprite[randomnumber][2]
		burnt_overlay.modulate.a = 0.0
		burnt_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
		burnt_overlay.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		child.add_child(burnt_overlay)
		burnt_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		human_burnt_overlays.append(burnt_overlay)

		# Create individual timer for this human
		var timer = Timer.new()
		timer.one_shot = true
		timer.timeout.connect(_on_human_timeout.bind(n))
		add_child(timer)
		human_timers.append(timer)

		# Start timer with random duration
		var random_time = randf_range(min_human_time, max_human_time)
		human_initial_times.append(random_time)
		timer.start(random_time)
		print("Human " + str(n) + " has " + str(random_time) + " seconds")



func FindAnUnderWare() -> int:
	var randomnumber:int = randi_range(0,stringSprite.size()-1)
	if underwareHuman_map.has(randomnumber):
		return randomnumber
	return FindAnUnderWare()
	
func SpawnUnderWare(UnderWare):
	var endamount:int = 0
	for n in underwareHuman_map:
		if n == -1:
			endamount +=1
	if endamount == underwareHuman_map.size():
		RoundWon()
		return
	if stringPoints[0].texture == null:
		nextUnderWare = UnderWare
		stringSprite[UnderWare]
		underwareHuman_map[underwareHuman_map.find(UnderWare)] = -1
		UnderWare = FindAnUnderWare()
	currentUnderware = nextUnderWare
	stringPoints[1].texture = stringSpriteUI[currentUnderware]
	stringPoints[0].texture = stringSpriteUI[UnderWare]
	nextUnderWare = UnderWare
	underwareHuman_map[underwareHuman_map.find(UnderWare)] = -1
	print(underwareHuman_map)
func RoundWon():
	print("you won the Round")
	current_wave += 1

	if current_wave > max_waves:
		# Game completed, load end scene
		get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
	else:
		# Start next wave
		StartWave()
	pass


func ClearRound():
	underwareHuman_map = []
	underwareHumanConst = []
	ManOrWoman = []
	stringPoints[0].texture = null
	stringPoints[1].texture = null

	# Clear all human timers
	for timer in human_timers:
		timer.stop()
		timer.queue_free()
	human_timers = []
	human_initial_times = []

	# Clear all brown/burnt overlays
	for overlay in human_brown_overlays:
		overlay.queue_free()
	human_brown_overlays = []

	for overlay in human_burnt_overlays:
		overlay.queue_free()
	human_burnt_overlays = []

	for i in range(HumanSpawnPoints.size()):
		var child: TextureButton = HumanSpawnPoints[i].get_child(0)
		var child1: TextureRect = HumanSpawnPoints[i].get_child(1)
		child.texture_normal = null
		child1.texture = null


func RemoveUnderWare():
	if stringPoints[0].texture == null:
		RoundWon()
	else:
		stringPoints[0].texture = null
		currentUnderware = nextUnderWare
		stringPoints[1].texture = stringSpriteUI[currentUnderware]
		
		
func addUnderware(Index, humanIndex):
	var child: TextureRect =  HumanSpawnPoints[humanIndex].get_child(1)
	if ManOrWoman[humanIndex]:
		child.texture = stringSprite[Index+7]
	else:
		child.texture = stringSprite[Index]
	
	# Stop the human's timer since they got their underwear
	if humanIndex < human_timers.size():
		human_timers[humanIndex].stop()

func ChangeTheWrongString(WrongSpace,underWareUsed):
	#underwareHuman_map[underwareHuman_map.find(underWareUsed)] = WrongSpace
	print(underwareHuman_map)

func _on_texture_button_button_up(extra_arg_0):
	if (underwareHumanConst[extra_arg_0] == currentUnderware):
		Globals.score+=10
		print("correct")
		var spawnpoint:GPUParticles2D =HumanSpawnPoints[extra_arg_0].get_child(5)
		spawnpoint.emitting = true
	else:
		Globals.lifes-=1
		ChangeTheWrongString(underwareHumanConst[extra_arg_0],currentUnderware)
		print("wrong")
		var spawnpoint:GPUParticles2D =HumanSpawnPoints[extra_arg_0].get_child(4)
		spawnpoint.emitting = true
		if Globals.lifes<=0:
			get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
			return
	animationPlayer.play("String")
	addUnderware(currentUnderware, extra_arg_0)
	var endamount:int = 0
	for n in underwareHuman_map:
		if n == -1:
			endamount +=1
	if endamount != underwareHuman_map.size():
		SpawnUnderWare(FindAnUnderWare())
	else:
		RemoveUnderWare()

func _on_human_timeout(human_index: int):
	Globals.lifes -= 1

	if Globals.lifes <= 0:
		get_tree().change_scene_to_file("res://Scenes/EndScene.tscn")
		return

	# Mark this human as served (even though they timed out)
	var underwear_type = underwareHumanConst[human_index]
	addUnderware(underwear_type, human_index)
	underwareHuman_map[human_index] = -1

	# Check if round is complete
	var endamount:int = 0
	for n in underwareHuman_map:
		if n == -1:
			endamount +=1
	if endamount == underwareHuman_map.size():
		RoundWon()
