extends Node2D

const HUMAN_SCALE = Vector2(0.25, 0.25)

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

@export var HumanSpawnPoints: Array[Control]
@export var stringPoints: Array[Sprite2D]

@export var stringButton:Array[Control]

@onready var humanSprite = [humanSprite0,humanSprite1,humanSprite2,humanSprite3,humanSprite4,humanSprite5,humanSprite6,humanSprite7,humanSprite8]

var currentUnderware:int
var nextUnderWare:int
var underwareHuman_map : Array[int]
var underwareHumanConst :Array[int]




func _ready():
	Spawnhumans(7)
	SpawnUnderWare(FindAnUnderWare())
	
	
func Spawnhumans(Amount):
	for n in Amount:
		var randomnumber: int = randi_range(0,1)
		var child: TextureButton =  HumanSpawnPoints[n].get_child(0) 
		child.texture_normal = humanSprite[randomnumber][0]
		HumanSpawnPoints[n].scale = HUMAN_SCALE
		underwareHuman_map.append(randomnumber)
		underwareHumanConst.append(randomnumber)



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
	if stringPoints[0].texture == null:
		nextUnderWare = FindAnUnderWare()
		stringSprite[nextUnderWare]
		underwareHuman_map[underwareHuman_map.find(nextUnderWare)] = -1
	currentUnderware = nextUnderWare
	stringPoints[1].texture = stringSpriteUI[currentUnderware]
	stringPoints[0].texture = stringSpriteUI[UnderWare]
	nextUnderWare = UnderWare
	underwareHuman_map[underwareHuman_map.find(UnderWare)] = -1

	print(underwareHuman_map)
func RoundWon():
	print("you won the Round")
	pass
func RemoveUnderWare():
	if stringPoints[0].texture == null:
		RoundWon()
	else:
		stringPoints[0].texture = null
func addUnderware(Index, humanIndex):
	var child: TextureRect =  HumanSpawnPoints[humanIndex].get_child(1)
	child.texture = stringSprite[Index]
	
func _on_texture_button_button_up(extra_arg_0):
	print("Human"+ str(extra_arg_0) + "CurrentString"+ str(underwareHuman_map[extra_arg_0]))
	if (underwareHumanConst[extra_arg_0] == currentUnderware):
		print("correct")
	else:
		print("wrong")
	addUnderware(currentUnderware, extra_arg_0)
	var endamount:int = 0
	for n in underwareHuman_map:
		if n == -1:
			endamount +=1
	if endamount != underwareHuman_map.size():
		SpawnUnderWare(FindAnUnderWare())
	else:
		RemoveUnderWare()
