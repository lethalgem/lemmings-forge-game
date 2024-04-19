class_name Forge
extends Node2D

@export var level: Level

@onready var ore = preload("res://scenes/ore.tscn")

func _on_area_2d_body_entered(body):
	if body is Ore and body._level_id == level.id:
		print(level.id)
		level.ore_absorbed()
		body.queue_free()
	#else:
		#print('*****************************************************')
		#print(body._level_id)
		#print(level.id)


func _process(delta):
	rotation -= 36 * delta * PI / 180
