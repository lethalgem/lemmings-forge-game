class_name Game
extends Node2D

@export var debug_enabled = false
@export var default_camera_move_speed = 20
@export var default_camera_zoom_speed = 0.025
@export var fast_camera_move_speed = 50
@export var fast_camera_zoom_speed = 0.1

@onready var camera = %GameCamera
@onready var debug_info = %DebugInfo
@onready var game_text = %GameText
@onready var level_1 = %Level1
@onready var level_2 = %Level2
@onready var level_3 = %Level3
@onready var level_4 = %Level4
@onready var level_5 = %Level5
@onready var level_6 = %Level6
@onready var level_7 = %Level7
@onready var level_8 = %Level8
@onready var level_9 = %Level9
@onready var level_10 = %Level10
@onready var level_11 = %Level11
@onready var level_12 = %Level12
@onready var level_13 = %Level13
@onready var level_14 = %Level14
@onready var level_15 = %Level15
@onready var level_16 = %Level16
@onready var level_17 = %Level17
@onready var level_18 = %Level18

var camera_enabled = true
var current_camera_move_speed = default_camera_move_speed
var current_camera_zoom_speed = default_camera_zoom_speed

func _ready():
	enter_level_1()
	#level_4.start()

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


func _physics_process(_delta):
	if debug_enabled:
		debug_info.text = "FPS:" + str(Engine.get_frames_per_second())

# ------ level transitions ------

func enter_level_1():
	game_text.queue_text("Howdy Boss! It's a big day in crazyville. Our miners have struck gold! Well not literally, more like iron. But it's as good as gold!", "What are you talking about?")
	game_text.queue_text("Boss! Now isn't the time to be playing around It's the first piece to the puzzle for the antimatter recipe.", "Oh right! So what do we do?")
	game_text.queue_text("Uh, you're the one in charge... let's start by getting the iron off planet x and to the refinery on x.", "Now that I can do!")
	await game_text.finished_displaying_text
	level_1.start()

func _on_level_1_level_completed():
	print("level 1 completed")
	enter_level_2()

func enter_level_2():
	level_2.start()

func _on_level_2_level_completed():
	print("level 2 completed")
	enter_level_3()

func enter_level_3():
	level_3.start()

# ------ ----------------- ------

func move_camera_to(new_position, new_zoom):
	create_tween().tween_property(camera, "position", new_position, 0.05).set_ease(Tween.EASE_IN_OUT)
	new_zoom = new_zoom.clamp(Vector2(0.1, 0.1), Vector2(5, 5))
	create_tween().tween_property(camera, "zoom", new_zoom, 0.05).set_ease(Tween.EASE_IN_OUT)
	create_tween().tween_property(camera, "scale", Vector2(1 / new_zoom.x, 1 / new_zoom.y), 0.05).set_ease(Tween.EASE_IN_OUT)

func _on_vsync_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

