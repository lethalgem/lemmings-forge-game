class_name BlackHole
extends Node2D

@export var initial_gravity:float = 10
@export var minimum_gravity:float = 1
@export var maximum_gravity:float = 20
@export var _parent: Level

const _gravityIncreaseModifier = 4
const _rotationIncreaseModifier = 2

var _currentGravity:float = 10
var increaseGravity = false
var decreaseGravity = false
var is_mouse_hovering = false
var ores_in_gravity_well = []

func _ready():
	set_process_input(true)
	setInitalGravity(initial_gravity)

func addCrate(ore_instance):
	ores_in_gravity_well.append(ore_instance)

func setInitalGravity(gravity):
	_currentGravity = gravity
	%HSlider.value = gravity
	#%GravityLabel.text = str(_currentGravity)

func gravityChanged(newValue: float):
	_currentGravity = newValue
	#%GravityLabel.text = str(_currentGravity)

const SPEED = 300.0
const ROTATION_SPEED = 10
var target_angle : float

func rotateHole(delta):
	target_angle = %InnerCircle.rotation + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta / 180
	%InnerCircle.rotation = target_angle
	target_angle = %OuterCircle.rotation + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta * .4 / 180
	%OuterCircle.rotation = target_angle
	target_angle = %MoreOuterCircle.rotation + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta * .2 / 180
	%MoreOuterCircle.rotation = target_angle

	#scale.x = _currentGravity / 10
	#scale.y = _currentGravity / 10

func checkGravityUpdate(delta):
	if increaseGravity:
		_currentGravity = _currentGravity + delta * _gravityIncreaseModifier
		_currentGravity = min(_currentGravity, maximum_gravity)
		%HSlider.value = _currentGravity
	elif decreaseGravity:
		_currentGravity = _currentGravity - delta * _gravityIncreaseModifier
		_currentGravity = max(_currentGravity, minimum_gravity)
		%HSlider.value = _currentGravity

func _process(_delta):
	if Input.is_action_pressed("left_click") and is_mouse_hovering:
		increaseGravity = true
	else:
		increaseGravity = false

	if Input.is_action_pressed("right_click") and is_mouse_hovering:
		decreaseGravity = true
	else:
		decreaseGravity = false

func _physics_process(delta):
	var gravityModifier:float = _currentGravity

	var gravityBase:float = 400000

	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		ore.update(direction_from_ore_to_self, distance_to_ore, gravityModifier * gravityBase, delta)

	rotateHole(delta)
	checkGravityUpdate(delta)

	#if increaseGravity:
		#_currentGravity = _currentGravity + delta * _gravityIncreaseModifier
		#%HSlider.value = _currentGravity
	#elif decreaseGravity:
		#_currentGravity = _currentGravity - delta * _gravityIncreaseModifier
		#%HSlider.value = _currentGravity

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

func _on_black_hole_mouse_entered():
	is_mouse_hovering = true

func _on_black_hole_mouse_exited():
	is_mouse_hovering = false
