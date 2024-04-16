extends Level

@onready var black_hole1: BlackHole = %BlackHole1
@onready var black_hole2: BlackHole = %BlackHole2
@onready var black_hole3: BlackHole = %BlackHole3

func _ready():
	setPlanet(%Planet)
	
	super()
	print("ready")
	black_hole1.setParent(self)
	black_hole1.setInitalGravity(12)
	
	black_hole2.setParent(self)
	black_hole2.setInitalGravity(12)
	
	black_hole3.setParent(self)
	black_hole3.setInitalGravity(12)
