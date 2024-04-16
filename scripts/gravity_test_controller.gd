extends Level

@onready var ore = preload("res://scenes/ore.tscn")

func _ready():
	id = -1

	%WormHole1.setPair(%WormHole2)
	%WormHole2.setPair(%WormHole1)

	%WhiteHole1.setParent(self)

	%BlackHole1.setParent(self)
	%BlackHole2.setParent(self)
	%BlackHole3.setParent(self)

	%WhiteHole1.setInitalGravity(18)

	%BlackHole1.setInitalGravity(12)
	%BlackHole2.setInitalGravity(3)
	%BlackHole3.setInitalGravity(15)

	%StartPlanet.setLevel(self)
	%EndPlanet.setLevel(self)

	%StartPlanet.startCrates()

func deleteOre(body):
	remove_child(body)

func crateAdded(ore_instance):
	var currentGlobalPosition = ore_instance.global_position
	add_child(ore_instance)
	ore_instance.global_position = currentGlobalPosition

	#%WhiteHole1.addCrate(ore_instance)

	#%BlackHole1.addCrate(ore_instance)
	#%BlackHole2.addCrate(ore_instance)
	#%BlackHole3.addCrate(ore_instance)
