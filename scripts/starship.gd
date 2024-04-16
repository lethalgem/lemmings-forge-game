class_name Starship
extends Node2D

@onready var ore = preload("res://scenes/ore.tscn")
var _level: Level

var ores_in_gravity_well = []

func setLevel(level):
	print("setting level")
	_level = level


var _currentRotation = 0
#var _launchVector = Vector2(2, -1)
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

func rotationChanged(newValue: float):
	_currentRotation = -newValue
	#rotation = _currentRotation
	setLaunchVectorFromRotation()

func _on_body_entered(body):
	if body is Ore:
		#print("ore entered gravity well")

		#var index = ores_in_gravity_well.find(body)
		#if index >= 0:
			#ores_in_gravity_well.remove_at(index)
			#_level.deleteOre(body)
		if body.createdPlanet != self:
			_level.deleteOre(body)
			sendCrate()


func sendCrate():
	var ore_instance = ore.instantiate()
	#add_child(ore_instance)
	#ore_instance.global_position = Vector2(-50 + randf_range(-5,5),200 + randf_range(-5,5)) # get_global_mouse_position()
	ore_instance.global_position = global_position
	ore_instance.forceDirection(_launchVector)
	ore_instance.setCreatePlanet(self, _level.id)
	_level.crateAdded(ore_instance)

	await get_tree().create_timer(.1).timeout
	#startCrates()
