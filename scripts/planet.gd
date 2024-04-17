class_name Planet
extends Node2D

@onready var ore = preload("res://scenes/ore.tscn")

var _level: Level
var ores_in_gravity_well = []
var is_mouse_hovering = false
var increaseAngle = false
var decreaseAngle = false
var _currentRotation = 0
var _launchVector = Vector2(1, 0)

func _process(_delta):
	if Input.is_action_pressed("left_click") and is_mouse_hovering:
		increaseAngle = true
	else:
		increaseAngle = false

	if Input.is_action_pressed("right_click") and is_mouse_hovering:
		decreaseAngle = true
	else:
		decreaseAngle = false

func _physics_process(_delta):
	if increaseAngle:
		_currentRotation += 1
		setLaunchVectorFromRotation()
	elif decreaseAngle:
		_currentRotation -= 1
		setLaunchVectorFromRotation()

func setLevel(level):
	print("setting level")
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

func rotationChanged(newValue: float):
	_currentRotation = -newValue
	setLaunchVectorFromRotation()

func _on_body_entered(body):
	if body is Ore:
		if body.createdPlanet != self:
			_level.deleteOre(body)


func startCrates():
	var ore_instance = ore.instantiate()
	ore_instance.global_position = global_position
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
