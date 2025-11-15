extends Node2D

const HUMAN_SCALE = Vector2(0.125, 0.125)

@export var stringSprite : Array[Texture2D]
@export var humanSprite : Array[Texture2D]

@export var HumanSpawnPoints: Array[Control]
@export var stringPoints: Array[Sprite2D]

var currentUnderware:int


func _ready():
	Spawnhumans(2)
	
	
func Spawnhumans(Amount):
	for n in Amount:
		var randomnumber: int = randi_range(0,3)
		var child: TextureButton =  HumanSpawnPoints[n].get_child(0) 
		child.texture_normal = humanSprite[randomnumber]
		HumanSpawnPoints[n].scale = HUMAN_SCALE
		

func StringAssociate():
	pass

func _on_texture_button_button_up(extra_arg_0):
	print(extra_arg_0)
