class_name BlackHole
extends Node2D




var increaseGravity = false
var decreaseGravity = false

func _ready():
	#%HoleCollision.set_pickable(true)
	set_process_input(true)
	pass

#func _input_event(event):
	#if event is InputEventMouseButton:
		#if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_mouse_within_collision_area(event.global_position): # Change BUTTON_LEFT to the button you want to detect
			#increaseGravity = true
		#elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT: # Change BUTTON_LEFT to the button you want to detect
			#increaseGravity = false
		#elif event.pressed and event.button_index == MOUSE_BUTTON_RIGHT and is_mouse_within_collision_area(event.global_position): # Change BUTTON_LEFT to the button you want to detect
			#decreaseGravity = true
		#elif not event.pressed and event.button_index == MOUSE_BUTTON_RIGHT: # Change BUTTON_LEFT to the button you want to detect
			#decreaseGravity = false

func is_mouse_within_collision_area(mouse_position):
	#var space_state = get_world_2d().direct_space_state
	#var result = space_state.intersect_point(mouse_position)
	#return result.collider == %HoleCollision

	var local_mouse_position = to_local(mouse_position)
	var collider = %HoleCollision # Replace with your collision shape's name
	return collider.shape.intersects(local_mouse_position)

	#return %HoleCollision.shape.collide(mouse_position,,)


var ores_in_gravity_well = []

@onready var _parent = null
func setParent(parent):
	_parent = parent

func addCrate(ore_instance):
	ores_in_gravity_well.append(ore_instance)

var _currentGravity = -1
func setInitalGravity(gravity):
	_currentGravity = gravity
	%HSlider.value = gravity
	%GravityLabel.text = str(_currentGravity)

func gravityChanged(newValue: float):
	_currentGravity = newValue
	%GravityLabel.text = str(_currentGravity)



const SPEED = 300.0
const ROTATION_SPEED = 10
var target_angle : float

func _physics_process(delta):
	#var gravityModifier:float = float(%HSlider.value)
	var gravityModifier:float = _currentGravity

	var gravityBase:float = 400000

	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		ore.update(direction_from_ore_to_self, distance_to_ore, gravityModifier * gravityBase, delta)

	#var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var velocity = direction * SPEED
	#target_angle = %BlackHole.rotation - (_currentGravity ) * 10 * PI / 180
	#print(target_angle)
	#%BlackHole.rotation = lerp_angle(%BlackHole.rotation, target_angle, delta)
	target_angle = %InnerCircle.rotation + (_currentGravity ) * 100 * PI * delta / 180
	%InnerCircle.rotation = target_angle
	target_angle = %OuterCircle.rotation + (_currentGravity ) * 100 * PI * delta * .4 / 180
	%OuterCircle.rotation = target_angle
	target_angle = %MoreOuterCircle.rotation + (_currentGravity ) * 100 * PI * delta * .2 / 180
	%MoreOuterCircle.rotation = target_angle

	#if increaseGravity:
		#_currentGravity = _currentGravity + delta
		#%HSlider.value = _currentGravity
	#elif decreaseGravity:
		#_currentGravity = _currentGravity - delta
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
