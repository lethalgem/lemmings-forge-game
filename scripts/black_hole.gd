extends Area2D

@onready var ore = preload("res://scenes/ore.tscn")
@onready var cast_to_ore = %DirectionRayCast
var ores_in_gravity_well = []

func _input(event):
	if event.is_action_pressed("left_click"):
		var ore_instance = ore.instantiate()
		add_child(ore_instance)
		ore_instance.global_position = get_global_mouse_position()

func _draw():
	for ore in ores_in_gravity_well:
		draw_line(global_position, ore.global_position, Color(255,0, 255), 10)

func _physics_process(delta):
	for ore in ores_in_gravity_well:
		var direction_from_ore_to_self = ore.global_position.direction_to(global_position)
		var distance_to_ore = ore.global_position.distance_to(global_position)
		print(direction_from_ore_to_self)
		print(distance_to_ore)


func _on_body_entered(body):
	if body is Ore:
		print("ore entered gravity well")
		ores_in_gravity_well.append(body)
