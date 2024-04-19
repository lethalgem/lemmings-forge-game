class_name WormHole
extends Node2D

@export var pair: WormHole

@onready var ore = preload("res://scenes/ore.tscn")

var ores_in_gravity_well = []

func _on_body_entered(body):
	if body is Ore:
		if pair != null:
			if body.sentThroughWormHole:
				body.receivedThroughWormHole()
			else:
				body.enteredWormHole()
				body.global_position = pair.global_position
