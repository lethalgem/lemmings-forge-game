class_name Ore
extends CharacterBody2D

var current_direction = Vector2(1,0)
var _level_id: int

@onready var _speedModifier = 1
@onready var current_velocity = 300 * _speedModifier
const minSpeed = 250

var createdPlanet = null
func setCreatePlanet(planet, level_id):
	_level_id = level_id
	createdPlanet = planet

@onready var _beenDetected = false
func beenDetected():
	return _beenDetected
func setBeenDetected():
	_beenDetected = true

func forceDirection(direction:Vector2):
	current_direction = direction.normalized()

#func _physics_process(delta):
func _process(delta):
	var sortedKeys = _gravitySources.keys()
	sortedKeys.sort()
	for blackHole in sortedKeys:
		#print(blackHole)
		var direction_from_ore_to_blackHole = self.global_position.direction_to(_gravitySources[blackHole][0])
		var distance_to_ore = self.global_position.distance_to(_gravitySources[blackHole][0])
		update(direction_from_ore_to_blackHole, distance_to_ore, blackHole.getCurrentGravity(), delta) #_gravitySources[blackHole][1], delta)

	var new_position = global_position + (current_direction * current_velocity * delta)
	#create_tween().tween_property(self, "global_position", new_position, delta)
	global_position = new_position

@onready var _inGravityBubble = false
func enteredGravityBubble():
	_inGravityBubble = true
func exitedGravityBubble():
	_inGravityBubble = false

@onready var sentThroughWormHole = false
func enteredWormHole():
	sentThroughWormHole = true
func receivedThroughWormHole():
	sentThroughWormHole = false


var _gravitySources = {}
func addGravitySource(blackHole:BlackHole):
	_gravitySources[blackHole] = [blackHole.getPosition(), blackHole.getCurrentGravity()]
func removeGravitySource(blackHole:BlackHole):
	if blackHole in _gravitySources:
		_gravitySources.erase(blackHole)


func update(direction:Vector2, distance:float, gravity:float, delta:float):

	#if distance > 700 or _inGravityBubble:
	if distance > 500 or _inGravityBubble:
		return

	var impactVector = pow(_speedModifier, 2.0/3) * direction * gravity * delta / (pow(distance, 1.5))
	#var impactVector = _speedModifier * direction * gravity * delta / (pow(distance, 1.5))
	var newVector = (current_direction * current_velocity) + impactVector

	var originalVelocity = current_velocity
	current_velocity = newVector.length()
	#current_velocity = min(originalVelocity * (1.05 + (pow(1.05, _speedModifier) - 1.05) / 3), current_velocity)
	#current_velocity = max(originalVelocity * (.95 - (.95 - pow(.95, _speedModifier)) / 3), current_velocity)
	current_velocity = min(originalVelocity * 1.05, current_velocity)
	current_velocity = max(originalVelocity * .95, current_velocity)
	current_velocity = max(minSpeed, current_velocity)


	current_direction = newVector.normalized()
