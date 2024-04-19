class_name WhiteHole
extends BlackHole

func _ready():
	super()

func getCurrentGravity():
	return -1 * _currentGravity * gravityBase;

func _physics_process(delta):

	rotateHole(delta)
	checkGravityUpdate(delta)
