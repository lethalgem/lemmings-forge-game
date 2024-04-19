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
@onready var main_menu = %MainMenu
@onready var scorecard: Scorecard = %Scorecard
@onready var win_screen = %WinScreen
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

var camera_controls_enabled = true
var current_camera_move_speed = default_camera_move_speed
var current_camera_zoom_speed = default_camera_zoom_speed
var previous_camera_position: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;

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
	if Input.is_action_just_released("zoom_in") and camera_controls_enabled:
		new_camera_zoom += Vector2(fast_camera_zoom_speed, fast_camera_zoom_speed)
	if Input.is_action_pressed("zoom_out") and camera_controls_enabled:
		new_camera_zoom += Vector2(-current_camera_zoom_speed, -current_camera_zoom_speed)
	if Input.is_action_just_released("zoom_out") and camera_controls_enabled:
		new_camera_zoom += Vector2(-fast_camera_zoom_speed, -fast_camera_zoom_speed)
	if camera.zoom != new_camera_zoom:
		new_camera_zoom = new_camera_zoom.clamp(Vector2(0.1, 0.1), Vector2(5, 5))
		create_tween().tween_property(camera, "zoom", new_camera_zoom, 0.05).set_ease(Tween.EASE_IN_OUT)
		create_tween().tween_property(camera, "scale", Vector2(1 / new_camera_zoom.x, 1 / new_camera_zoom.y), 0.05).set_ease(Tween.EASE_IN_OUT)


func _physics_process(_delta):
	if debug_enabled:
		debug_info.text = "FPS:" + str(Engine.get_frames_per_second())

# mouse camera controls
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		get_viewport().set_input_as_handled()
		if event.is_pressed():
			previous_camera_position = event.position
			_moveCamera = true
		else:
			_moveCamera = false
	elif event is InputEventMouseMotion and _moveCamera and camera_controls_enabled:
		get_viewport().set_input_as_handled()
		camera.position += (previous_camera_position - event.position) * Vector2(1 / camera.zoom.x, 1 / camera.zoom.y)
		previous_camera_position = event.position

func enter_menu():
	move_camera_to(Vector2(-1492, 54), Vector2(1.2, 1.2))

func _on_start_button_button_up():
	main_menu.visible = false
	enter_level_1()

func _on_controls_button_button_up():
	enter_controls()

func enter_controls():
	move_camera_to(Vector2(-1492, 914), Vector2(1.2, 1.2))

func _on_return_to_menu_button_button_up():
	enter_menu()

# ------ level transitions ------

func enter_level_1():
	move_camera_to(Vector2(-74, 54), Vector2(1.2, 1.2))
	await done_moving_camera
	game_text.queue_text("Howdy Boss! It's a big day in crazyville. Our miners have struck gold! Well not literally, more like iron. But it's as good as gold!", "What are you talking about?")
	game_text.queue_text("Boss! Now isn't the time to be playing around It's the first piece to the puzzle for the antimatter recipe.", "Oh right! So what do we do?")
	game_text.queue_text("Uh, you're the one in charge... let's start by getting the iron off planet x and to the refinery on x.", "Now that I can do!")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-74, 0), camera.zoom)
	await done_moving_camera
	level_1.start()

func _on_level_1_level_completed(time):
	print("level 1 completed")
	print(time)
	scorecard.update_scorecard(1, time)

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

func _on_level_2_level_completed(time):
	print("level 2 completed")
	print(time)
	scorecard.update_scorecard(2, time)
	enter_level_3()

func enter_level_3():
	camera_controls_enabled = false
	move_camera_to(Vector2(1698, -1261), Vector2(0.3, 0.3))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(1693, -1736), Vector2(0.45, 0.45))
	await done_moving_camera
	level_3.start()
	camera_controls_enabled = true

func _on_level_3_level_completed(time):
	print("level 3 completed")
	print(time)
	scorecard.update_scorecard(3, time)
	enter_level_4()

func enter_level_4():
	camera_controls_enabled = false
	move_camera_to(Vector2(2738, -1980), Vector2(0.55, 0.55))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(2707, -2220), Vector2(0.8, 0.8))
	await done_moving_camera
	level_4.start()
	camera_controls_enabled = true

func _on_level_4_level_completed(time):
	print("level 4 completed")
	print(time)
	scorecard.update_scorecard(4, time)
	enter_level_5()

func enter_level_5():
	camera_controls_enabled = false
	move_camera_to(Vector2(3871, -2920), Vector2(0.4, 0.4))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(3871, -3282), Vector2(0.4, 0.4))
	await done_moving_camera
	level_5.start()
	camera_controls_enabled = true

func _on_level_5_level_completed(time):
	print("level 5 completed")
	print(time)
	scorecard.update_scorecard(5, time)
	enter_level_6()

func enter_level_6():
	camera_controls_enabled = false
	move_camera_to(Vector2(7973, -4523), Vector2(1, 1))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(7973, -4617), Vector2(1, 1))
	await done_moving_camera
	level_6.start()
	camera_controls_enabled = true

func _on_level_6_level_completed(time):
	print("level 6 completed")
	print(time)
	scorecard.update_scorecard(6, time)
	enter_level_7()

func enter_level_7():
	camera_controls_enabled = false
	move_camera_to(Vector2(6261, -4801), Vector2(0.7, 0.7))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(6261, -5022), Vector2(0.8, 0.8))
	await done_moving_camera
	level_7.start()
	camera_controls_enabled = true

func _on_level_7_level_completed(time):
	print("level 7 completed")
	print(time)
	scorecard.update_scorecard(7, time)
	enter_level_8()

func enter_level_8():
	camera_controls_enabled = false
	move_camera_to(Vector2(5613, -4238), Vector2(0.4, 0.4))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(5613, -4570), Vector2(0.5, 0.5))
	await done_moving_camera
	level_8.start()
	camera_controls_enabled = true

func _on_level_8_level_completed(time):
	print("level 8 completed")
	print(time)
	scorecard.update_scorecard(8, time)
	enter_level_9()

func enter_level_9():
	camera_controls_enabled = false
	move_camera_to(Vector2(3083, -4894), Vector2(0.15, 0.15))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(3230, -5878), Vector2(0.22, 0.22))
	await done_moving_camera
	level_9.start()
	camera_controls_enabled = true

func _on_level_9_level_completed(time):
	print("level 9 completed")
	print(time)
	scorecard.update_scorecard(9, time)
	enter_level_10()

func enter_level_10():
	camera_controls_enabled = false
	move_camera_to(Vector2(-6043, -16406), Vector2(1, 1))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-6043, -16562), Vector2(1, 1))
	await done_moving_camera
	level_10.start()
	camera_controls_enabled = true

func _on_level_10_level_completed(time):
	print("level 10 completed")
	print(time)
	scorecard.update_scorecard(10, time)
	enter_level_11()

func enter_level_11():
	camera_controls_enabled = false
	move_camera_to(Vector2(-6094, -14502), Vector2(0.27, 0.27))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-6252, -15045), Vector2(0.35, 0.35))
	await done_moving_camera
	level_11.start()
	camera_controls_enabled = true

func _on_level_11_level_completed(time):
	print("level 11 completed")
	print(time)
	scorecard.update_scorecard(11, time)
	enter_level_12()

func enter_level_12():
	camera_controls_enabled = false
	move_camera_to(Vector2(-4396, -12567), Vector2(0.3, 0.3))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-4396, -13053), Vector2(0.3, 0.3))
	await done_moving_camera
	level_12.start()
	camera_controls_enabled = true

func _on_level_12_level_completed(time):
	print("level 12 completed")
	print(time)
	scorecard.update_scorecard(12, time)
	enter_level_13()

func enter_level_13():
	camera_controls_enabled = false
	move_camera_to(Vector2(5764, -5518), Vector2(0.07, 0.07))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(4497, -7373), Vector2(0.1, 0.1))
	await done_moving_camera
	level_13.start()
	camera_controls_enabled = true

func _on_level_13_level_completed(time):
	print("level 13 completed")
	print(time)
	scorecard.update_scorecard(13, time)
	enter_level_14()

func enter_level_14():
	camera_controls_enabled = false
	move_camera_to(Vector2(6229, -1496), Vector2(0.3, 0.3))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(6229, -2079), Vector2(0.3, 0.3))
	await done_moving_camera
	level_14.start()
	camera_controls_enabled = true

func _on_level_14_level_completed(time):
	print("level 14 completed")
	print(time)
	scorecard.update_scorecard(14, time)
	enter_level_15()

func enter_level_15():
	camera_controls_enabled = false
	move_camera_to(Vector2(7349, -5295), Vector2(0.12, 0.12))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(7349, -6543), Vector2(0.17, 0.17))
	await done_moving_camera
	level_15.start()
	camera_controls_enabled = true

func _on_level_15_level_completed(time):
	print("level 15 completed")
	print(time)
	scorecard.update_scorecard(15, time)
	enter_level_16()

func enter_level_16():
	camera_controls_enabled = false
	move_camera_to(Vector2(-1147, -11375), Vector2(0.1, 0.1))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-1163, -12815), Vector2(0.14, 0.14))
	await done_moving_camera
	level_16.start()
	camera_controls_enabled = true

func _on_level_16_level_completed(time):
	print("level 16 completed")
	print(time)
	scorecard.update_scorecard(16, time)
	enter_level_17()

func enter_level_17():
	camera_controls_enabled = false
	move_camera_to(Vector2(4533, -8255), Vector2(0.235, 0.235))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(4533, -9455), Vector2(0.235, 0.235))
	await done_moving_camera
	level_17.start()
	camera_controls_enabled = true

func _on_level_17_level_completed(time):
	print("level 17 completed")
	print(time)
	scorecard.update_scorecard(17, time)
	enter_level_18()

func enter_level_18():
	camera_controls_enabled = false
	move_camera_to(Vector2(1853, -8303), Vector2(0.44, 0.44))
	await done_moving_camera
	game_text.queue_text("I'm placeholder", "test")
	await game_text.finished_displaying_text
	move_camera_to(Vector2(469, -7751), Vector2(0.265, 0.265))
	await done_moving_camera
	level_18.start()
	camera_controls_enabled = true

func _on_level_18_level_completed(time):
	print("level 18 completed")
	print(time)
	print("WIN")
	scorecard.update_scorecard(18, time)
	win_screen.visible = true
	move_camera_to(Vector2(-1511, -5396), Vector2(1.2, 1.2))
	await done_moving_camera
	scorecard._on_win()

# ------ ----------------- ------

func move_camera_to(new_position: Vector2, new_zoom: Vector2, seconds_to_complete = 0.5):
	camera_controls_enabled = false
	create_tween().tween_property(camera, "global_position", new_position, seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	new_zoom = new_zoom.clamp(Vector2(0.03, 0.03), Vector2(5, 5))
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
