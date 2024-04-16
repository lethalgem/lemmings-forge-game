class_name Level
extends Node2D

signal level_completed

@export var debug_enabled = false
@export var id = 0
@export var ore_goal = 10
@export var planet: Planet

@onready var ore_count_label: Label = %OreCountLabel
@onready var black_hole: BlackHole = %BlackHole

var ores_delivered = 0

func _ready():
	planet.setLevel(self)
	black_hole.setParent(self)
	if debug_enabled:
		planet.startCrates()

func start():
	planet.startCrates()

func deleteOre(body):
	remove_child(body)

func crateAdded(ore_instance):
	var currentGlobalPosition = ore_instance.global_position
	add_child(ore_instance)
	ore_instance.global_position = currentGlobalPosition

func ore_absorbed():
	if ores_delivered < ore_goal:
		ores_delivered += 1
		update_ore_count_label()
		check_if_level_completed()

func check_if_level_completed():
	if ores_delivered == ore_goal:
		print("level " + str(id) + " completed")
		emit_signal("level_completed")

func update_ore_count_label():
	ore_count_label.text = "Ore Delivered: " + str(ores_delivered) + "/" + str(ore_goal)
