class_name Game
extends Node2D

signal done_moving_camera

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

var camera_controls_enabled = false
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
	if Input.is_action_pressed("pan_left") and camera_controls_enabled:
		new_camera_position += Vector2(-current_camera_move_speed, 0)
	if Input.is_action_pressed("pan_right") and camera_controls_enabled:
		new_camera_position += Vector2(current_camera_move_speed, 0)
	if Input.is_action_pressed("pan_up") and camera_controls_enabled:
		new_camera_position += Vector2(0, -current_camera_move_speed)
	if Input.is_action_pressed("pan_down") and camera_controls_enabled:
		new_camera_position += Vector2(0, current_camera_move_speed)
	if camera.global_position != new_camera_position:
		create_tween().tween_property(camera, "position", new_camera_position, 0.05).set_ease(Tween.EASE_IN_OUT)

	# camera zoom controls
	var new_camera_zoom = camera.zoom
	if Input.is_action_pressed("zoom_in") and camera_controls_enabled:
		new_camera_zoom += Vector2(current_camera_zoom_speed, current_camera_zoom_speed)
	if Input.is_action_pressed("zoom_out") and camera_controls_enabled:
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
	move_camera_to(Vector2(-74, 0), camera.zoom)
	await done_moving_camera
	level_1.start()

func _on_level_1_level_completed():
	print("level 1 completed")
	enter_level_2()

func enter_level_2():
	camera_controls_enabled = false
	move_camera_to(Vector2(357, 0), camera.zoom)
	await done_moving_camera
	game_text.queue_text("Nice job! Now that iron has arrived, we can get it refined and ready for the next phase", "The next phase...?, of course!")
	game_text.queue_text("That's right. Soon it'll be time for you know what and you know who will never see it coming!", "Well let's get this show on the road then.")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(1057, -200), Vector2(0.8, 0.8))
	await done_moving_camera
	game_text.queue_text("There's the next destination. It looks like there are two black holes in the way this time. See if you can get the ingots there... in one piece this time.", "I make no promises.")
	game_text.queue_text("(P.S. use WASD to move the camera, and Q or E to change the zoom level)", "Watch me work.")
	await game_text.finished_displaying_text
	level_2.start()
	camera_controls_enabled = true

func _on_level_2_level_completed():
	print("level 2 completed")
	enter_level_3()

func enter_level_3():
	level_3.start()
func _on_level_3_level_completed():
	print("level 3 completed")
	enter_level_4()

func enter_level_4():
	level_4.start()
func _on_level_4_level_completed():
	print("level 4 completed")
	enter_level_5()

func enter_level_5():
	level_5.start()
func _on_level_5_level_completed():
	print("level 5 completed")
	enter_level_6()

func enter_level_6():
	level_6.start()
func _on_level_6_level_completed():
	print("level 6 completed")
	enter_level_7()

func enter_level_7():
	level_7.start()
func _on_level_7_level_completed():
	print("level 7 completed")
	enter_level_8()

func enter_level_8():
	level_8.start()
func _on_level_8_level_completed():
	print("level 8 completed")
	enter_level_9()

func enter_level_9():
	level_9.start()
func _on_level_9_level_completed():
	print("level 9 completed")
	enter_level_10()

func enter_level_10():
	level_10.start()
func _on_level_10_level_completed():
	print("level 10 completed")
	enter_level_11()

func enter_level_11():
	level_11.start()
func _on_level_11_level_completed():
	print("level 11 completed")
	enter_level_12()

func enter_level_12():
	level_12.start()
func _on_level_12_level_completed():
	print("level 12 completed")
	enter_level_13()

func enter_level_13():
	level_13.start()
func _on_level_13_level_completed():
	print("level 13 completed")
	enter_level_14()

func enter_level_14():
	level_14.start()
func _on_level_14_level_completed():
	print("level 14 completed")
	enter_level_15()

func enter_level_15():
	level_15.start()
func _on_level_15_level_completed():
	print("level 15 completed")
	enter_level_16()

func enter_level_16():
	level_16.start()
func _on_level_16_level_completed():
	print("level 16 completed")
	enter_level_17()

func enter_level_17():
	level_17.start()
func _on_level_17_level_completed():
	print("level 17 completed")
	enter_level_18()

func enter_level_18():
	level_18.start()
func _on_level_18_level_completed():
	print("level 18 completed")
	print("WIN")
	print("WIN")
	print("WIN")
	print("WIN")
# ------ ----------------- ------

func move_camera_to(new_position: Vector2, new_zoom: Vector2, seconds_to_complete = 0.5):
	camera_controls_enabled = false
	create_tween().tween_property(camera, "global_position", new_position, seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	new_zoom = new_zoom.clamp(Vector2(0.1, 0.1), Vector2(5, 5))
	create_tween().tween_property(camera, "zoom", new_zoom, seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	var tween = create_tween().tween_property(camera, "scale", Vector2(1 / new_zoom.x, 1 / new_zoom.y), seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	await get_tree().create_timer(.3).timeout
	emit_signal("done_moving_camera")

func _on_vsync_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


