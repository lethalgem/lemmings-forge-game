extends Level

@onready var black_hole: BlackHole = %BlackHole

func _ready():
	super()
	print("ready")
	black_hole.setParent(self)
	black_hole.setInitalGravity(12)
