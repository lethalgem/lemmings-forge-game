extends Level

@onready var black_hole1: BlackHole = %BlackHole1
@onready var black_hole2: BlackHole = %BlackHole2
@onready var black_hole3: BlackHole = %BlackHole3
@onready var black_hole4: BlackHole = %BlackHole4
@onready var black_hole5: BlackHole = %BlackHole5

func _ready():
	setPlanet(%Planet)
	%Starship.setLevel(self)
	
	super()
	print("ready")
	black_hole1.setParent(self)
	black_hole1.setInitalGravity(15)
	
	black_hole2.setParent(self)
	black_hole2.setInitalGravity(5)
	
	black_hole3.setParent(self)
	black_hole3.setInitalGravity(20)
	
	black_hole4.setParent(self)
	black_hole4.setInitalGravity(5)
	
	black_hole5.setParent(self)
	black_hole5.setInitalGravity(16)
