class_name Level
extends Node2D

signal level_completed(time: float)

@export var debug_enabled = false
@export var id = 0
@export var ore_goal = 10
@export var planet: Planet
@export var nextLevel: Level

@onready var forge: Forge = %Forge

var ores_delivered = 0
var time_elapsed = 0.0
var level_started = false

func setPlanet(thisPlanet):
	planet = thisPlanet

func _ready():
	planet.setLevel(self)
	if debug_enabled:
		planet.startCrates()

func _process(delta):
	if level_started:
		time_elapsed += delta

func start():
	level_started = true
	forge.show_goal_highlight(true)
	planet.startCrates()

func deleteOre(body):
	body.queue_free()

func crateAdded(ore_instance):
	var currentGlobalPosition = ore_instance.global_position
	add_child(ore_instance)
	move_child(ore_instance, 0)
	ore_instance.global_position = currentGlobalPosition

var _lastOreId = -1
var levelAlreadyCompleted = false
func ore_absorbed(ore):
	
	if ore.oreId == _lastOreId + 1:
		ores_delivered += 1
	else:
		ores_delivered = 1
	
	_lastOreId = ore.oreId
	
	#var z = %Forge
	if ores_delivered >= ore_goal and not levelAlreadyCompleted:
		#ores_delivered += 1
		#print_ore_count()
		check_if_level_completed()
		levelAlreadyCompleted = true
	
	if levelAlreadyCompleted and nextLevel != null and not nextLevel.planet.sendCratesIndependently:
		nextLevel.planet.startCrates()

func check_if_level_completed():
	if ores_delivered == ore_goal:
		print("level " + str(id) + " completed")
		#var z = %Forge
		forge.show_goal_highlight(false)
		#forgePassIn.show_goal_highlight(false)
		emit_signal("level_completed", time_elapsed)
		level_started = false

func print_ore_count():
	print("Ore Delivered: " + str(ores_delivered) + "/" + str(ore_goal))
