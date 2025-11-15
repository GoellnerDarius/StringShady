extends Node2D

const HUMAN_SCALE = Vector2(0.125, 0.125)

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
var noUnderWareAmount:int
var underwareHuman_map : Array[int] 




func _ready():
	for i in HumanSpawnPoints.size():
		underwareHuman_map.append(0)
	Spawnhumans(7)
	SpawnUnderWare(FindAnUnderWare())
	
	
func Spawnhumans(Amount):
	noUnderWareAmount += Amount 
	for n in Amount:
		var randomnumber: int = randi_range(0,1)
		var child: TextureButton =  HumanSpawnPoints[n].get_child(0) 
		child.texture_normal = humanSprite[randomnumber][0]
		HumanSpawnPoints[n].scale = HUMAN_SCALE
		StringAssociate(n)

func StringAssociate(currentHuman):
	var randomnumber:int = randi_range(0,stringSprite.size()-1)
	underwareHuman_map[currentHuman] = randomnumber

func FindAnUnderWare() -> int:
	var randomnumber:int = randi_range(0,stringSprite.size()-1)
	for n in underwareHuman_map:
		if randomnumber == underwareHuman_map[n]:
			return randomnumber
	return FindAnUnderWare()
	
func SpawnUnderWare(UnderWare):
	if noUnderWareAmount < 2:
		if stringPoints[0].texture == null:
			RoundWon()
		else:
			stringPoints[0].texture = null
	if stringPoints[0].texture == null:
		nextUnderWare = FindAnUnderWare()
		stringSprite[nextUnderWare]
	currentUnderware = nextUnderWare
	stringPoints[1].texture = stringSprite[currentUnderware]
	stringPoints[0].texture = stringSprite[UnderWare]
	nextUnderWare = UnderWare

func RoundWon():
	pass

func _on_texture_button_button_up(extra_arg_0):
	print("Human"+ str(extra_arg_0) + "CurrentString"+ str(underwareHuman_map[extra_arg_0]))
	if (underwareHuman_map[extra_arg_0] == currentUnderware):
		print("correct")
	else:
		print("wrong")
