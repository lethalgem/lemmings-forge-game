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
@onready var click_player: AudioStreamPlayer = %ButtonClickPlayer
@onready var start_click_player: AudioStreamPlayer = %StartButtonClickPlayer
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
	#enter_level_7()
	enter_menu()

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
	start_click_player.play()
	enter_level_1()
	
func _on_l1_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_1()
	
func _on_l2_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_2(true)
	
func _on_l3_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_3(true)
	
func _on_l4_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_4(true)
	
func _on_l5_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_5(true)
	
func _on_l6_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_6(true)
	
func _on_l7_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_7(true)
	
func _on_l8_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_8(true)
	
func _on_l9_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_9(true)
	
func _on_l10_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_10(true)
	
func _on_l11_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_11(true)
	
func _on_l12_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_12(true)
	
func _on_l13_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_13(true)
	
func _on_l14_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_14(true)
	
func _on_l15_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_15(true)
	
func _on_l16_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_16(true)
	
func _on_l17_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_17(true)
	
func _on_l18_button_up():
	main_menu.visible = false
	start_click_player.play()
	enter_level_18(true)
	
	
	
	
	
	
	
	
	
	
	
	
	
	

func _on_controls_button_button_up():
	click_player.play()
	enter_controls()

func enter_controls():
	move_camera_to(Vector2(-1492, 914), Vector2(1.2, 1.2))

func _on_return_to_menu_button_button_up():
	click_player.play()
	enter_menu()

# ------ level transitions ------

func enter_level_1():
	move_camera_to(Vector2(-74, 54), Vector2(1.2, 1.2), 1.5)
	await done_moving_camera
	await get_tree().create_timer(1.5).timeout
	
	game_text.queue_text("So you think you've got what it takes? Looks like Kenny's just sending anyone our way. I hope your hearts made of stone kid.", "Umm, what??")
	game_text.queue_text("Where's my manners. Welcome to the 100% legal galactic antimatter forge. We make the make the most valuable item in the galaxy.", "How do we do that?")
	game_text.queue_text("What do you mean? You don't know how to control planets and gravity? Where have you trucked ore before???", "Just tell me what to do")
	game_text.queue_text("Left click and right click a planet to turn it. Left click and right blackholes to make them stronger or weaker.", "Got it")
	game_text.queue_text("And if that ain't enough for ya, you can use the left and right arrow keys too.", "Nifty")
	game_text.queue_text("Now get to WORK! Move some palantium from Arcadia to Chronus!", "On it boss!")
	
	await game_text.finished_displaying_text
	move_camera_to(Vector2(-74, 0), camera.zoom)
	await done_moving_camera
	level_1.start()

func _on_level_1_level_completed(time):
	print("level 1 completed")
	print(time)
	scorecard.update_scorecard(1, time)
	enter_level_2()

func enter_level_2(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
	
	camera_controls_enabled = false
	
	move_camera_to(Vector2(357, 0), camera.zoom)
	await done_moving_camera
	game_text.queue_text("Maybe you do have what it takes. Don't get comfy, galatic life ain't for maggots.", "Just give me the next job")
	await game_text.finished_displaying_text
	
	move_camera_to(Vector2(1057, -200), Vector2(0.8, 0.8))
	await done_moving_camera
	game_text.queue_text("Here you go then. Let's see if we can make a trucker out of you yet cowboy.", "As long as I get paid")
	game_text.queue_text("Oh, you'll get paid kid. Chronus is melting the palantium into amelthor. You tracking the forge yet? ", "Antimatter here we come!")
	game_text.queue_text("Good, now get the amelthor from Chronus to Draco.", "On it!")
	game_text.queue_text("Oh, and feel free to pan around the map by clicking and dragging or zoom out with a scroll. Now get to work!.", "Oh, that's cool!")
	game_text.queue_text("Or if you prefer, use WASD to pan around and QE to zoom in and out. Now really, get to work!.", "I will as soon as you let me.")
	await game_text.finished_displaying_text
	level_2.start()
	camera_controls_enabled = true

func _on_level_2_level_completed(time):
	print("level 2 completed")
	print(time)
	scorecard.update_scorecard(2, time)
	enter_level_3()

func enter_level_3(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
	
	camera_controls_enabled = false
	move_camera_to(Vector2(1698, -1261), Vector2(0.3, 0.3))
	await done_moving_camera

	game_text.queue_text("You're catching on!", "I know I'm a king")
	game_text.queue_text("Okay, okay, hold your guns taco! The men on Draco are forging the amelthor into iron smelt, one of two thing needed for mexor.", "What is this? Science?")
	game_text.queue_text("Huh, science! Heck yeah science! Aight, move the iron smelt from Draco to Sirius.", "About time!")
	game_text.queue_text("Oh, and those white holes? Yeah, that's the opposite of a black hole, it's gravity repulses stuff.", "Let me do my work!")
	
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

func enter_level_4(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(2738, -1980), Vector2(0.55, 0.55))
	await done_moving_camera
	
	game_text.queue_text("Great work peon! Sirius has the iron smelt, you got the guts to keep moving product?", "I'm catching on chief")
	game_text.queue_text("We need the mexor from Sirius. Send flexcore from Astralis to Sirius so we can smelt iron smelt and flexcore to make mexor.", "That easy?")
	game_text.queue_text("Shut up and do your work!", "(to myself) What's his issue")
	
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

func enter_level_5(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
	
	camera_controls_enabled = false
	move_camera_to(Vector2(3871, -2920), Vector2(0.4, 0.4))
	await done_moving_camera
	
	game_text.queue_text("Finally, we're making mexor! Don Tito can finally get off my back for the backup!", "Don Tito? Don? What's happening here?")
	game_text.queue_text("Nothing! I said NOTHING! No Dons, nothings happening here. You keep going or you better watch out for your family!", "I.. I.. Yes sir!")
	game_text.queue_text("Good! Now move move the mexor from Sirius to Nova Prime!", "On it Boss!")
	
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

func enter_level_6(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(7973, -4523), Vector2(1, 1))
	await done_moving_camera
	
	game_text.queue_text("Good, mexor delivered! You're sniffing your nose in the wrong hole. I'm moving you to Elysium", "The home of poison ore, you tryin' to kill me?")
	game_text.queue_text("You scared? Don't have what it takes?", "Just tell me what's going on here?")
	game_text.queue_text("None of your business! Start moving lithiod from Elysium to Lyra. Oh and...", "And what? 'Boss'...")
	game_text.queue_text("Watch out for those gravity bubbles, gravity doesn't exist there", "Let me see...")
	
	await game_text.finished_displaying_text
	move_camera_to(Vector2(7973, -4617), Vector2(1, 1))
	await done_moving_camera
	level_6.start()
	camera_controls_enabled = true

func _on_level_6_level_completed(time):
	level_1.planet.sendCratesIndependently = true
	print("level 6 completed")
	print(time)
	scorecard.update_scorecard(6, time)
	enter_level_7()

func enter_level_7(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(6261, -4801), Vector2(0.7, 0.7))
	await done_moving_camera
	
	game_text.queue_text("You're doing well, Dons Carlo and Lucky will be pleased.", "Alright, tell me what's going on?")
	game_text.queue_text("Alright, it's time to cut you in. We're the Gotti Mafia. We've created a swarm of black holes to disrupt antimatter production.", "Disrupting production?")
	game_text.queue_text("Yeah, and now we're getting the operations moving for ourselves.", "And what if I say no?")
	game_text.queue_text("If you like breathing, you're gonna keep moving ore, trucker!", "You got me, I like breathing.")
	game_text.queue_text("Good choice! Lyra is crafting the lithiod into hardened neurotox, get it moving to Vespera.", "(to myself) looks like everything is going according to plan")
	game_text.queue_text("Oh, and feel free to send ore through the spaceships. You can move them just like a planet.", "I like the new tech!")
	
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

func enter_level_8(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(5613, -4238), Vector2(0.4, 0.4))
	await done_moving_camera
	
	game_text.queue_text("I think you are starting to be my friend. Vespera is breaking the neurotox into liquid neurofil. Get it to Nova Prime asap.", "(to myself) He'll never see it coming!")
	
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

func enter_level_9(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(3083, -4894), Vector2(0.15, 0.15))
	await done_moving_camera
	
	game_text.queue_text("Nova Prime is pumping! It's now producing 99.999% pure plutonium, 1/3 elements needed for antimatter. Send it out to the Antimatter Vault! The size of a massive planet! Must be worth $1,000,000,000,000,000,000,000,000!", "I'd for y'all to lose it!")
	
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

func enter_level_10(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(-6043, -16406), Vector2(1, 1))
	await done_moving_camera
	
	game_text.queue_text("We're moving to a different quadrant. Get product from Aria to Nocturne. Oh, watch out for those gray black holes, we haven't figured out the science yet to control those!", "I hate it when mafia science fails!")
	
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

func enter_level_11(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(-6094, -14502), Vector2(0.27, 0.27))
	await done_moving_camera
	
	game_text.queue_text("I think you just might make it in this business. Keep the chain going, get that urium from Nocturne to Indigo. Pup.", "I've been talking to Don Tito, I don't know that you'll make it.")
	game_text.queue_text("What was that???", "Shut up, I'm moving ore.")
	
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

func enter_level_12(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(-4396, -12567), Vector2(0.3, 0.3))
	await done_moving_camera
	
	game_text.queue_text("I'm starting to get tired of you, any last words?", "(knock out goon Bobby)")
	game_text.queue_text("(Don Tito, who you will now be talking to) Thanks Don Fred (that's you!), the Gotti mafia isn't for everyone.", "We should've gotten rid of him earlier")
	game_text.queue_text("I agree, Bobby was a flake. You know the plan, let's get the refined uridium moving from Indigo to Hyperion. ", "Yup, that was my plan")
	
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

func enter_level_13(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(5764, -5518), Vector2(0.07, 0.07))
	await done_moving_camera
	
	game_text.queue_text("Alright, the big jump with the most dangerouos transfer, pure alpha particles, radioactive and ready to ignite!", "I know, this is the challenging step")
	game_text.queue_text("You can do it champ, move the alphas from hyperion to xanadu.", "I've been looking forward to this jump!")
	
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

func enter_level_14(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		level_14.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(6229, -1496), Vector2(0.3, 0.3))
	await done_moving_camera
	
	game_text.queue_text("You made it! I was terrified you'd die on that trip.", "I don't fear death, death fears me.")
	game_text.queue_text("I pitty the men who cross you. Xanadu is packing the alpha particales into solid alphaX. Get it to Astralis to include in their shipments!", "We're almost there my friend.")
	game_text.queue_text("Also, don't fret to use those worm holes for instant transport. Bet you were those worked on the last jump.", "About time the science figures that out!")
	
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

func enter_level_15(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		level_14.planet.sendCratesIndependently = true
		level_15.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(7349, -5295), Vector2(0.12, 0.12))
	await done_moving_camera
	
	game_text.queue_text("Only 4 more jumps, I can't believe it's working, we are going to be able to buy the galaxy.", "Our dream")
	game_text.queue_text("Let's go to Nova Prime's moon Exoterra, start moving the heavy metals. Let's get extratium moving from Exoterra to Verdante.", "Extratium, only found on Verdante")
	game_text.queue_text("Keep using those wormholes.", "It's the only way")
	
	
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

func enter_level_16(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		level_14.planet.sendCratesIndependently = true
		level_15.planet.sendCratesIndependently = true
		level_16.planet.sendCratesIndependently = true
		
	camera_controls_enabled = false
	move_camera_to(Vector2(-1147, -11375), Vector2(0.1, 0.1))
	await done_moving_camera

	game_text.queue_text("Next metal, another moon. Let's get platinum/gold duox moving from Nocturne's moon Icaria to Celestis. ", "Yup, the metal that sank Atlantis.")
	
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

func enter_level_17(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		level_14.planet.sendCratesIndependently = true
		level_15.planet.sendCratesIndependently = true
		level_16.planet.sendCratesIndependently = true
		level_17.planet.sendCratesIndependently = true
		
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

func enter_level_18(fromGameStart = false):
	if(fromGameStart):
		level_1.planet.sendCratesIndependently = true
		level_2.planet.sendCratesIndependently = true
		level_3.planet.sendCratesIndependently = true
		level_4.planet.sendCratesIndependently = true
		level_5.planet.sendCratesIndependently = true
		level_6.planet.sendCratesIndependently = true
		level_7.planet.sendCratesIndependently = true
		level_8.planet.sendCratesIndependently = true
		level_9.planet.sendCratesIndependently = true
		level_10.planet.sendCratesIndependently = true
		level_11.planet.sendCratesIndependently = true
		level_12.planet.sendCratesIndependently = true
		level_13.planet.sendCratesIndependently = true
		level_14.planet.sendCratesIndependently = true
		level_15.planet.sendCratesIndependently = true
		level_16.planet.sendCratesIndependently = true
		level_17.planet.sendCratesIndependently = true
		level_18.planet.sendCratesIndependently = true
		
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

func move_camera_to(new_position: Vector2, new_zoom: Vector2, seconds_to_complete = 1):
	camera_controls_enabled = false
	scorecard.visible = false
	create_tween().tween_property(camera, "global_position", new_position, seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	new_zoom = new_zoom.clamp(Vector2(0.03, 0.03), Vector2(5, 5))
	create_tween().tween_property(camera, "zoom", new_zoom, seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	var tween = create_tween().tween_property(camera, "scale", Vector2(1 / new_zoom.x, 1 / new_zoom.y), seconds_to_complete).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	await get_tree().create_timer(.3).timeout
	scorecard.visible = true
	emit_signal("done_moving_camera")

func _on_vsync_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
