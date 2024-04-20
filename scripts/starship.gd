class_name Starship
extends Node2D

@export var spaceshipId = 1
@export var _level: Level

@onready var ore = preload("res://scenes/ore.tscn")
@onready var forward_highlight = %ForwardHighlight
@onready var reverse_highlight = %ReverseHighlight
@onready var change_angle_player: AudioStreamPlayer2D = %ChangeAnglePlayer

var ores_in_gravity_well = []
var is_playing_sound = false
var increaseAngle: bool = false:
	set(value):
		if value:
			forward_highlight.visible = true
			reverse_highlight.visible = false
			if not is_playing_sound:
				is_playing_sound = true
				change_angle_player.play()
		elif not value and is_mouse_hovering and not decreaseAngle:
			forward_highlight.visible = true
			reverse_highlight.visible = true
			if is_playing_sound:
				is_playing_sound = false
				change_angle_player.stop()
		increaseAngle = value
	get:
		return increaseAngle
var decreaseAngle: bool = false:
	set(value):
		if value:
			forward_highlight.visible = false
			reverse_highlight.visible = true
			if not is_playing_sound:
				is_playing_sound = true
				change_angle_player.play()
		elif not value and is_mouse_hovering and not increaseAngle:
			forward_highlight.visible = true
			reverse_highlight.visible = true
			if is_playing_sound:
				is_playing_sound = false
				change_angle_player.stop()
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



var nextOreId = 0
func sendCrate():
	var ore_instance = ore.instantiate()
	ore_instance.global_position = global_position
	ore_instance.oreId = nextOreId
	nextOreId += 1
	
	ore_instance.forceDirection(_launchVector)
	ore_instance.setCreatePlanet(self, _level.id)
	_level.crateAdded(ore_instance)

	await get_tree().create_timer(.1).timeout


func _on_area_mouse_entered():
	is_mouse_hovering = true

func _on_area_mouse_exited():
	is_mouse_hovering = false
