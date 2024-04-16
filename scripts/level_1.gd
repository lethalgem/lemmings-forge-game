extends Level


@onready var black_hole: BlackHole = %BlackHole
@onready var black_hole_2: BlackHole = %BlackHole2

func _ready():
	super()
	black_hole.setParent(self)
	black_hole_2.setParent(self)
