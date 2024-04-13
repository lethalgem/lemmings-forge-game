extends Area2D

@onready var ore = preload("res://scenes/ore.tscn")
@onready var cast_to_ore = %DirectionRayCast
var ores_in_gravity_well = []

func startCrates():
	var ore_instance = ore.instantiate()
	add_child(ore_instance)
	ore_instance.global_position = Vector2(-50,200) # get_global_mouse_position()
	ores_in_gravity_well.append(ore_instance)
	
	await get_tree().create_timer(.1).timeout
	startCrates()
#func _input(event):
	#if event.is_action_pressed("left_click"):
		#var ore_instance = ore.instantiate()
		#add_child(ore_instance)
		#ore_instance.global_position = get_global_mouse_position()
		#
		#ores_in_gravity_well.append(ore_instance)

# func _draw():
# 	for ore in ores_in_gravity_well:
# 		draw_line(global_position, ore.global_position, Color(255,0, 255), 10)

func _physics_process(delta):
	#var gravityModifier:float = float(%GravityText.text)
	var gravityModifier:float = float(%HSlider.value)
	
	#print(gravityModifier)
	
	var gravityBase:float = 400000

	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		# print(direction_from_ore_to_self)
		# print(distance_to_ore)
		ore.update(direction_from_ore_to_self, distance_to_ore, gravityModifier * gravityBase, delta)


func _on_body_entered(body):
	if body is Ore:
		print("ore entered gravity well")
		
		if not body.beenDetected():
			body.setBeenDetected()
			return
		
		var index = ores_in_gravity_well.find(body)
		if index >= 0:
			ores_in_gravity_well.remove_at(index)
			remove_child(body)
			 
		#ores_in_gravity_well.append(body)
