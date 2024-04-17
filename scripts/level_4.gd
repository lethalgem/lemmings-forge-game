extends Level

@onready var white_hole: WhiteHole = %WhiteHole
@onready var extraDarkBlackHole: ExtraDarkBlackHole = %ExtraDarkBlackHole

func _ready():
	%Starship1.setLevel(self)
	%Starship2.setLevel(self)

	super()
	print("ready")
	white_hole.setParent(self)
	white_hole.setInitalGravity(2)

	extraDarkBlackHole.setParent(self)
	extraDarkBlackHole.setInitalGravity(12)
