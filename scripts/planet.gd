class_name Planet
extends Node2D

@onready var ore = preload("res://scenes/ore.tscn")
@onready var forward_highlight = %ForwardHighlight
@onready var reverse_highlight = %ReverseHighlight

@export var minimum_added_rotation:float = -45
@export var maximum_added_rotation:float = 45

var _level: Level
var ores_in_gravity_well = []
var _currentRotation = 0
var _launchVector = Vector2(1, 0)
const _rotationIncreaseModifier = 1
var _initial_rotation = 0
var increaseAngle: bool = false:
	set(value):
		if value:
			forward_highlight.visible = true
			reverse_highlight.visible = false
		elif not value and is_mouse_hovering and not decreaseAngle:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		increaseAngle = value
	get:
		return increaseAngle
var decreaseAngle: bool = false:
	set(value):
		if value:
			forward_highlight.visible = false
			reverse_highlight.visible = true
		elif not value and is_mouse_hovering and not increaseAngle:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		decreaseAngle = value
	get:
		return decreaseAngle
var is_mouse_hovering: bool = false:
	set(value):
		if value and not increaseAngle and not decreaseAngle:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		else:
			forward_highlight.visible = false
			reverse_highlight.visible = false
		is_mouse_hovering = value
	get:
		return is_mouse_hovering

func _ready():
	_initial_rotation = rad_to_deg(rotation)
	_currentRotation = _initial_rotation
	setLaunchVectorFromRotation()

func _process(_delta):
	if Input.is_action_pressed("left_click") and is_mouse_hovering:
		decreaseAngle = true
	else:
		decreaseAngle = false

	if Input.is_action_pressed("right_click") and is_mouse_hovering:
		increaseAngle = true
	else:
		increaseAngle = false

func _physics_process(_delta):
	if increaseAngle:
		_currentRotation += _rotationIncreaseModifier
		_currentRotation = min(_currentRotation, _initial_rotation + maximum_added_rotation)
		setLaunchVectorFromRotation()
	elif decreaseAngle:
		_currentRotation -= _rotationIncreaseModifier
		_currentRotation = max(_currentRotation, _initial_rotation + minimum_added_rotation)
		setLaunchVectorFromRotation()

func setLevel(level):
	_level = level

func setInitalRotation(initialRotation):
	_currentRotation = initialRotation
	%VSlider.value = _currentRotation
	setLaunchVectorFromRotation()

func setLaunchVectorFromRotation():
	var radians = deg_to_rad(_currentRotation)
	_launchVector.x = cos(radians)
	_launchVector.y = sin(radians)
	_launchVector = _launchVector.normalized()
	rotation = radians

func rotationChanged(newValue: float):
	_currentRotation = -newValue
	setLaunchVectorFromRotation()

func _on_body_entered(body):
	if _level.id == 15 or _level.id == 16:
		return

	if body is Ore:
		if body.createdPlanet != self:
			print("----------------------")
			print(body.createdPlanet._level.id)
			print(self._level.id)
			_level.deleteOre(body)


func startCrates():
	%LaunchPad.visible = true

	var ore_instance = ore.instantiate()
	ore_instance.global_position = Vector2((%LaunchPad.global_position.x + %LaunchPad2.global_position.x) / 2, (%LaunchPad.global_position.y + %LaunchPad2.global_position.y) / 2 )

	ore_instance.forceDirection(_launchVector)
	ore_instance.setCreatePlanet(self, _level.id)
	_level.crateAdded(ore_instance)

	await get_tree().create_timer(.3).timeout
	startCrates()


func _on_area_mouse_entered():
	print("hovering")
	is_mouse_hovering = true

func _on_area_mouse_exited():
	is_mouse_hovering = false
