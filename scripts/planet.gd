extends Node2D

@onready var ore = preload("res://scenes/ore.tscn")
@onready var cast_to_ore = %DirectionRayCast
var ores_in_gravity_well = []

@onready var _parent = null
func setParent(parent):
	_parent = parent

func _on_body_entered(body):
	if body is Ore:
		print("ore entered gravity well")
		
		#var index = ores_in_gravity_well.find(body)
		#if index >= 0:
			#ores_in_gravity_well.remove_at(index)
			#_parent.deleteOre(body)
		if body.createdPlanet != self:
			_parent.deleteOre(body)


func startCrates():
	var ore_instance = ore.instantiate()
	#add_child(ore_instance)
	#ore_instance.global_position = Vector2(-50 + randf_range(-5,5),200 + randf_range(-5,5)) # get_global_mouse_position()
	ore_instance.global_position = global_position
	ore_instance.forceDirection(Vector2(2, 1))
	ore_instance.setCreatePlanet(self)
	_parent.crateAdded(ore_instance)
	
	await get_tree().create_timer(.2).timeout
	startCrates()
