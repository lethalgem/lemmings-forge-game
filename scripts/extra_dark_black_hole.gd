class_name ExtraDarkBlackHole
extends Node2D

@export var _parent: Level
@export var _currentGravity = 10

var ores_in_gravity_well = []
const SPEED = 300.0
const ROTATION_SPEED = 10
var target_angle : float

func _ready():
	set_process_input(true)

func setParent(parent):
	_parent = parent

func addCrate(ore_instance):
	ores_in_gravity_well.append(ore_instance)


func gravityChanged(newValue: float):
	_currentGravity = newValue

func _physics_process(delta):
	var gravityModifier:float = _currentGravity

	var gravityBase:float = 400000

	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		ore.update(direction_from_ore_to_self, distance_to_ore, gravityModifier * gravityBase, delta)

	target_angle = %InnerCircle.rotation + (_currentGravity ) * 100 * PI * delta / 180
	%InnerCircle.rotation = target_angle
	target_angle = %OuterCircle.rotation + (_currentGravity ) * 100 * PI * delta * .4 / 180
	%OuterCircle.rotation = target_angle
	target_angle = %MoreOuterCircle.rotation + (_currentGravity ) * 100 * PI * delta * .2 / 180
	%MoreOuterCircle.rotation = target_angle

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
