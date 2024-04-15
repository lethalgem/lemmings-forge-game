class_name OreBackup
extends CharacterBody2D

#@onready var current_direction = Vector2(1,0)
var current_direction = Vector2(1,0)
@onready var current_velocity = 300

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

#func rotate_vector_around_vector(vector):
	#var angle = acos(vector.x * current_direction.x + vector.y * current_direction.y)
	#
	#var cos_angle = cos(angle)
	#var sin_angle = sin(angle)
	#var x = vector.x - current_direction.x
	#var y = vector.y - current_direction.y
	#var new_x = x * cos_angle - y * sin_angle
	#var new_y = x * sin_angle + y * cos_angle
	#return Vector2(new_x + current_direction.x, new_y + current_direction.y)

func update(direction:Vector2, distance:float, gravity:float, delta:float):

	if distance > 700:
		return

	#distance = max(distance, 750)
	var impactVector = direction * gravity * delta / (pow(distance, 1.5))
	#if impactVector.length() > 300:
		#impactVector = impactVector.normalized() * 300

	var newVector = (current_direction * current_velocity) + impactVector 
	
	var originalVelocity = current_velocity
	current_velocity = newVector.length()
	current_velocity = min(originalVelocity * 1.05, current_velocity)
		
	current_direction = newVector.normalized()

	#var velocityCap = 600
	#if current_velocity > velocityCap:
		#newVector = current_direction * velocityCap
		#current_velocity = newVector.length()
		#current_direction = newVector.normalized()


#
#
#
#
#
#
#
	#var secondsToOrbit = 2
	#var radians = delta * 360 * secondsToOrbit * PI / 180
	#
	#var center:Vector2 = Vector2(global_position.x + direction.x * distance, global_position.y + direction.y * distance)
	#
	#var halfCirlcePoint = Vector2(center.x - direction.x * distance / 2, center.y + direction.y - distance / 2)
	#var impactVector = Vector2(halfCirlcePoint.x - global_position.x, halfCirlcePoint.y - global_position.y).normalized()
	#print(impactVector)
	#
	#var newVector = (current_direction * current_velocity) + impactVector * gravity
#
#
	##distance = max(distance, 750)
	##var impactVector = direction * gravity * delta / distance # (pow(distance, 3.0/2))
	##if impactVector.length() > 300:
		##impactVector = impactVector.normalized() * 300
#
	##var newVector = (current_direction * current_velocity) + impactVector 
	#
	#current_velocity = newVector.length()
	#current_direction = newVector.normalized()
#
	##var velocityCap = 600
	##if current_velocity > velocityCap:
		##newVector = current_direction * velocityCap
		##current_velocity = newVector.length()
		##current_direction = newVector.normalized()
#
#
#
#




















	#var newX = cos(radians)*distance + center.x
	#var newY = cos(radians)*distance + center.y
#
	#print(center)
	#print(newX,',',newY)
#
#
#
#
	#var perpendicularDirection = Vector2(direction.y, -direction.x)
	##var rotatedVector = rotate_vector_around_vector(perpendicularDirection).normalized()
#
	##var impactVector = Vector2(newX - global_position.x, newY - global_position.y)
	##var newVector = (current_direction * current_velocity) + impactVector 
	#
	##current_velocity = newVector.length()
	## current_direction = newVector.normalized()
	#current_direction = (current_direction + perpendicularDirection).normalized()












	# distance = max(distance, 750)
	# var impactVector = direction * gravity * delta / distance # (pow(distance, 3.0/2))
	# if impactVector.length() > 300:
	# 	impactVector = impactVector.normalized() * 300

	# var newVector = (current_direction * current_velocity) + impactVector 
	
	# current_velocity = newVector.length()
	# current_direction = newVector.normalized()

	# var velocityCap = 600
	# if current_velocity > velocityCap:
	# 	newVector = current_direction * velocityCap
	# 	current_velocity = newVector.length()
	# 	current_direction = newVector.normalized()






#
#
	#distance = max(distance, 750)
	#var impactVector = direction * gravity * delta / distance # (pow(distance, 3.0/2))
	#if impactVector.length() > 300:
		#impactVector = impactVector.normalized() * 300
#
	#var newVector = (current_direction * current_velocity) + impactVector 
	#
	#current_velocity = newVector.length()
	#current_direction = newVector.normalized()
#
	#var velocityCap = 600
	#if current_velocity > velocityCap:
		#newVector = current_direction * velocityCap
		#current_velocity = newVector.length()
		#current_direction = newVector.normalized()
#




	# if current_velocity > 500:
	# 	print(current_direction, current_velocity, direction, distance, gravity, delta)
	
