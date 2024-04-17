class_name Game
extends Node2D

@export var debug_enabled = false
@export var default_camera_move_speed = 20
@export var default_camera_zoom_speed = 0.025
@export var fast_camera_move_speed = 50
@export var fast_camera_zoom_speed = 0.1

@onready var camera = %GameCamera
@onready var level_1 = %Level1
@onready var debug_info = %DebugInfo

var camera_enabled = true
var current_camera_move_speed = default_camera_move_speed
var current_camera_zoom_speed = default_camera_zoom_speed

func _ready():
	enter_level_1()

func _process(_delta):
	if Input.is_action_pressed("fast_camera_modifier"):
		current_camera_move_speed = fast_camera_move_speed
		current_camera_zoom_speed = fast_camera_zoom_speed
	else:
		current_camera_move_speed = default_camera_move_speed
		current_camera_zoom_speed = default_camera_zoom_speed

	# camera panning controls
	var new_camera_position = camera.global_position
	if Input.is_action_pressed("pan_left") and camera_enabled:
		new_camera_position += Vector2(-current_camera_move_speed, 0)
	if Input.is_action_pressed("pan_right") and camera_enabled:
		new_camera_position += Vector2(current_camera_move_speed, 0)
	if Input.is_action_pressed("pan_up") and camera_enabled:
		new_camera_position += Vector2(0, -current_camera_move_speed)
	if Input.is_action_pressed("pan_down") and camera_enabled:
		new_camera_position += Vector2(0, current_camera_move_speed)
	if camera.global_position != new_camera_position:
		create_tween().tween_property(camera, "position", new_camera_position, 0.05).set_ease(Tween.EASE_IN_OUT)

	# camera zoom controls
	var new_camera_zoom = camera.zoom
	if Input.is_action_pressed("zoom_in") and camera_enabled:
		new_camera_zoom += Vector2(current_camera_zoom_speed, current_camera_zoom_speed)
	if Input.is_action_pressed("zoom_out") and camera_enabled:
		new_camera_zoom += Vector2(-current_camera_zoom_speed, -current_camera_zoom_speed)
	if camera.zoom != new_camera_zoom:
		new_camera_zoom = new_camera_zoom.clamp(Vector2(0.1, 0.1), Vector2(5, 5))
		create_tween().tween_property(camera, "zoom", new_camera_zoom, 0.05).set_ease(Tween.EASE_IN_OUT)
		create_tween().tween_property(camera, "scale", Vector2(1 / new_camera_zoom.x, 1 / new_camera_zoom.y), 0.05).set_ease(Tween.EASE_IN_OUT)
		#scale = Vector2(1 / zoom.x, 1 / zoom.y)

func _physics_process(_delta):
	if debug_enabled:
		debug_info.text = "FPS:" + str(Engine.get_frames_per_second())

# ------ level transitions ------


func enter_level_1():
	level_1.start()

# ------ ----------------- ------


func _on_vsync_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
