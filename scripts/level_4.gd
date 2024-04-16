extends Level

@onready var white_hole: WhiteHole = %WhiteHole
@onready var black_hole1: BlackHole = %BlackHole1
@onready var black_hole2: BlackHole = %BlackHole2
@onready var black_hole3: BlackHole = %BlackHole3
@onready var black_hole4: BlackHole = %BlackHole4
@onready var extraDarkBlackHole: ExtraDarkBlackHole = %ExtraDarkBlackHole

func _ready():
	setPlanet(%Planet)
	%Starship1.setLevel(self)
	%Starship2.setLevel(self)
	
	super()
	print("ready")
	white_hole.setParent(self)
	white_hole.setInitalGravity(2)
	
	black_hole1.setParent(self)
	black_hole1.setInitalGravity(15)
	
	black_hole2.setParent(self)
	black_hole2.setInitalGravity(5)
	
	black_hole3.setParent(self)
	black_hole3.setInitalGravity(20)
	
	black_hole4.setParent(self)
	black_hole4.setInitalGravity(5)
	
	extraDarkBlackHole.setParent(self)
	extraDarkBlackHole.setInitalGravity(12)
