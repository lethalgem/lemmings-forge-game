class_name Game
extends Node2D

@export var camera_move_speed = 10
@export var camera_zoom_speed = 0.025

@onready var camera = %GameCamera
@onready var level_0 = %Level0
@onready var level_1 = %Level1

var camera_enabled = true

func _ready():
	enter_level_0()

func _process(_delta):
	# camera panning controls
	var new_camera_position = camera.global_position
	if Input.is_action_pressed("pan_left") and camera_enabled:
		new_camera_position += Vector2(-camera_move_speed, 0)
	if Input.is_action_pressed("pan_right") and camera_enabled:
		new_camera_position += Vector2(camera_move_speed, 0)
	if Input.is_action_pressed("pan_up") and camera_enabled:
		new_camera_position += Vector2(0, -camera_move_speed)
	if Input.is_action_pressed("pan_down") and camera_enabled:
		new_camera_position += Vector2(0, camera_move_speed)
	if camera.global_position != new_camera_position:
		create_tween().tween_property(camera, "position", new_camera_position, 0.05).set_ease(Tween.EASE_IN_OUT)

	# camera zoom controls
	var new_camera_zoom = camera.zoom
	if Input.is_action_pressed("zoom_in") and camera_enabled:
		new_camera_zoom += Vector2(camera_zoom_speed, camera_zoom_speed)
	if Input.is_action_pressed("zoom_out") and camera_enabled:
		new_camera_zoom += Vector2(-camera_zoom_speed, -camera_zoom_speed)
	if camera.zoom != new_camera_zoom:
		print(camera.zoom)
		create_tween().tween_property(camera, "zoom", new_camera_zoom.clamp(Vector2(0.1, 0.1), Vector2(5, 5)), 0.05).set_ease(Tween.EASE_IN_OUT)

func enter_level_0():
	level_0.start()

func _on_level_0_level_completed():
	print("level_0 done")
	enter_level_1()

func enter_level_1():
	level_1.start()
