extends Node

@onready var ore = preload("res://scenes/ore.tscn")

func _ready():
	%BlackHole1.setParent(self)
	%BlackHole2.setParent(self)
	%BlackHole3.setParent(self)
	
	%BlackHole1.setInitalGravity(12)
	%BlackHole2.setInitalGravity(3)
	%BlackHole3.setInitalGravity(15)
	
	%StartPlanet.setParent(self)
	%EndPlanet.setParent(self)
	%StartPlanet.startCrates()
	#%BlackHole.startCrates()
	#%BlackHole2.startCrates()
	
func deleteOre(body):
	remove_child(body)

func crateAdded(ore_instance):
	var currentGlobalPosition = ore_instance.global_position
	add_child(ore_instance)
	ore_instance.global_position = currentGlobalPosition
	
	%BlackHole1.addCrate(ore_instance)
	%BlackHole2.addCrate(ore_instance)
	%BlackHole3.addCrate(ore_instance)
