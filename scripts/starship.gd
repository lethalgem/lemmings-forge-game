class_name Starship
extends Node2D

@export var spaceshipId = 1

@export var _level: Level

@onready var ore = preload("res://scenes/ore.tscn")

var ores_in_gravity_well = []
var is_mouse_hovering = false
var increaseAngle = false
var decreaseAngle = false

func _ready():
	%Spaceship1.visible = false
	if spaceshipId == 1:
		%Spaceship1.visible = true
	if spaceshipId == 2:
		%Spaceship2.visible = true
	if spaceshipId == 3:
		%Spaceship3.visible = true
	if spaceshipId == 4:
		%Spaceship4.visible = true
	if spaceshipId == 5:
		%Spaceship5.visible = true
	if spaceshipId == 6:
		%Spaceship6.visible = true
	if spaceshipId == 7:
		%Spaceship7.visible = true
	if spaceshipId == 8:
		%Spaceship8.visible = true
	if spaceshipId == 9:
		%Spaceship9.visible = true
	if spaceshipId == 10:
		%Spaceship10.visible = true

	_currentRotation = rad_to_deg(rotation)
	setLaunchVectorFromRotation()

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


var _currentRotation = 0
var _launchVector = Vector2(1, 0)
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
	if body is Ore:
		if body.createdPlanet != self:
			_level.deleteOre(body)
			sendCrate()


func sendCrate():
	var ore_instance = ore.instantiate()
	ore_instance.global_position = global_position
	ore_instance.forceDirection(_launchVector)
	ore_instance.setCreatePlanet(self, _level.id)
	_level.crateAdded(ore_instance)

	await get_tree().create_timer(.1).timeout


func _on_area_mouse_entered():
	is_mouse_hovering = true

func _on_area_mouse_exited():
	is_mouse_hovering = false
