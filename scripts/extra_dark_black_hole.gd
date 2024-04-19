class_name ExtraDarkBlackHole
extends BlackHole

func _ready():
	super()

func _physics_process(delta):
	rotateHole(delta)
	checkGravityUpdate(delta)

func _on_black_hole_mouse_entered():
	pass

func _on_black_hole_mouse_exited():
	pass


func _on_outer_collision_entered(body):
	ores_in_gravity_well.append(body)
	body.addGravitySource(self)


func _on_outer_collision_exited(body):
	if body is Ore:
		body.removeGravitySource(self)

		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)
