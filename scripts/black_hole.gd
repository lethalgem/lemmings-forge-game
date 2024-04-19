class_name BlackHole
extends Node2D

@export var initial_gravity:float = 10
@export var minimum_gravity:float = 1
@export var maximum_gravity:float = 20
@export var _parent: Level

@onready var forward_highlight = %ForwardHighlight
@onready var reverse_highlight = %ReverseHighlight

const _gravityIncreaseModifier = 4
const _rotationIncreaseModifier = 2

var _currentGravity:float = 10
var ores_in_gravity_well = []
var increaseGravity: bool = false:
	set(value):
		if value:
			forward_highlight.visible = true
			reverse_highlight.visible = false
		elif not value and is_mouse_hovering and not decreaseGravity:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		increaseGravity = value
	get:
		return increaseGravity
var decreaseGravity: bool = false:
	set(value):
		if value:
			forward_highlight.visible = false
			reverse_highlight.visible = true
		elif not value and is_mouse_hovering and not increaseGravity:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		decreaseGravity = value
	get:
		return decreaseGravity
var is_mouse_hovering: bool = false:
	set(value):
		if value and not increaseGravity and not decreaseGravity:
			forward_highlight.visible = true
			reverse_highlight.visible = true
		else:
			forward_highlight.visible = false
			reverse_highlight.visible = false
		is_mouse_hovering = value
	get:
		return is_mouse_hovering


var id = -1

func _ready():
	set_process_input(true)

	_currentGravity = initial_gravity

	%InnerBlackHole.scale.x = _currentGravity / 25 + .5
	%InnerBlackHole.scale.y = _currentGravity / 25 + .5
	%OuterArea2.scale.x = _currentGravity / 25 + .5
	%OuterArea2.scale.y = _currentGravity / 25 + .5


func addCrate(ore_instance):
	ores_in_gravity_well.append(ore_instance)

func getCurrentGravity():
	return _currentGravity * gravityBase;
func getPosition():
	return global_position;


const SPEED = 300.0
const ROTATION_SPEED = 10
var target_angle : float

func rotateHole(delta):
	target_angle = %InnerCircle.rotation + ( 2 * PI / 180 ) + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta / 180
	%InnerCircle.rotation = target_angle
	%InnerBlackHole.rotation = target_angle / 8
	target_angle = %OuterCircle.rotation + ( 2 * PI / 180 ) + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta * .4 / 180
	%OuterCircle.rotation = target_angle
	target_angle = %MoreOuterCircle.rotation + ( 2 * PI / 180 ) + _rotationIncreaseModifier * _currentGravity * 100 * PI * delta * .2 / 180
	%MoreOuterCircle.rotation = target_angle

	%InnerBlackHole.scale.x = _currentGravity / 25 + .5
	%InnerBlackHole.scale.y = _currentGravity / 25 + .5
	%OuterArea2.scale.x = _currentGravity / 25 + .5
	%OuterArea2.scale.y = _currentGravity / 25 + .5
	if forward_highlight != null and reverse_highlight != null:
		forward_highlight.scale.x = _currentGravity / 25 + 1
		forward_highlight.scale.y = _currentGravity / 25 + 1
		reverse_highlight.scale.x = _currentGravity / 25 + 1
		reverse_highlight.scale.y = _currentGravity / 25 + 1

func checkGravityUpdate(delta):
	if increaseGravity:
		_currentGravity = _currentGravity + delta * _gravityIncreaseModifier
		_currentGravity = min(_currentGravity, maximum_gravity)

	elif decreaseGravity:
		_currentGravity = _currentGravity - delta * _gravityIncreaseModifier
		_currentGravity = max(_currentGravity, minimum_gravity)


func _process(_delta):
	if Input.is_action_pressed("left_click") and is_mouse_hovering:
		increaseGravity = true
	else:
		increaseGravity = false

	if Input.is_action_pressed("right_click") and is_mouse_hovering:
		decreaseGravity = true
	else:
		decreaseGravity = false

var gravityModifier:float = _currentGravity
var gravityBase:float = 400000
func _physics_process(delta):
	var gravityModifier:float = _currentGravity

	rotateHole(delta)
	checkGravityUpdate(delta)

func _on_body_entered(body):
	if body is Ore:
		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)

			body.removeGravitySource(self)

			if _parent != null:
				_parent.deleteOre(body)
			else:
				print('NULL PARENT WHEN TRYING TO REMOVE!!!!!!!!!!!!')

func _on_outer_collision_entered(body):
	ores_in_gravity_well.append(body)
	body.addGravitySource(self)


func _on_outer_collision_exited(body):
	if body is Ore:
		body.removeGravitySource(self)

		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)


func _on_black_hole_mouse_entered():
	is_mouse_hovering = true

func _on_black_hole_mouse_exited():
	is_mouse_hovering = false
