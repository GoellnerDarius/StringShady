extends Node2D

var scaleHumans = 0.125

@export var stringSprite : Array[Texture2D]
@export var humanSprite : Array[Texture2D]

@export var HumanSpawnPoints: Array[Sprite2D]
@export var stringPoints: Array[Sprite2D]

func _ready():
	for n in HumanSpawnPoints.size():
		var randomnumber: int = randi_range(0,3)
		HumanSpawnPoints[n].texture = humanSprite[randomnumber]
		HumanSpawnPoints[n].scale *= scaleHumans 
		
	
