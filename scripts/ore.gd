class_name Ore
extends CharacterBody2D

#@onready var current_direction = Vector2(1,0)
var current_direction = Vector2(1,0)
@onready var _speedModifier = 4
@onready var current_velocity = 300 * _speedModifier


var createdPlanet = null
func setCreatePlanet(planet):
	createdPlanet = planet 
	


@onready var _beenDetected = false
func beenDetected():
	return _beenDetected
func setBeenDetected():
	_beenDetected = true
	
func forceDirection(direction:Vector2):
	current_direction = direction.normalized()

func _physics_process(delta):
	var new_position = global_position + (current_direction * current_velocity * delta)
	create_tween().tween_property(self, "global_position", new_position, delta)

@onready var _inGravityBubble = false

func enteredGravityBubble():
	_inGravityBubble = true
func exitedGravityBubble():
	_inGravityBubble = false

func update(direction:Vector2, distance:float, gravity:float, delta:float):

	if distance > 700 or _inGravityBubble:
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
		
	current_direction = newVector.normalized()
