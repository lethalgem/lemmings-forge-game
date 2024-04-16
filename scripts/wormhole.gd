extends Node2D

class_name  WormHole

@onready var ore = preload("res://scenes/ore.tscn")
@onready var cast_to_ore = %DirectionRayCast
var ores_in_gravity_well = []

var _pair: WormHole = null
func setPair(pair):
	_pair = pair

func _on_body_entered(body):
	if body is Ore:
		if _pair != null:
			if body.sentThroughWormHole:
				body.receivedThroughWormHole()
			else:
				body.enteredWormHole()
				body.global_position = _pair.global_position
		#body.enteredGravityBubble()
			
#func _on_body_exited(body):
	#if body is Ore:
		#body.exitedGravityBubble()
		#
