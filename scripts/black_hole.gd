class_name BlackHole
extends Node2D



var ores_in_gravity_well = []

@onready var _parent = null
func setParent(parent):
	_parent = parent

func addCrate(ore_instance):
	ores_in_gravity_well.append(ore_instance)

var _currentGravity = -1
func setInitalGravity(gravity):
	_currentGravity = gravity
	%HSlider.value = gravity

func gravityChanged(newValue: float):
	_currentGravity = newValue

func _physics_process(delta):
	#var gravityModifier:float = float(%HSlider.value)
	var gravityModifier:float = _currentGravity

	var gravityBase:float = 400000

	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		ore.update(direction_from_ore_to_self, distance_to_ore, gravityModifier * gravityBase, delta)

func _on_body_entered(body):
	if body is Ore:
		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)
			_parent.deleteOre(body)

func _on_outer_collision_entered(body):
	ores_in_gravity_well.append(body)

func _on_outer_collision_exited(body):
	if body is Ore:
		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)
