extends Node2D

@onready var ore = preload("res://scenes/ore.tscn")
@onready var cast_to_ore = %DirectionRayCast
var ores_in_gravity_well = []

func _on_body_entered(body):
	if body is Ore:
		body.enteredGravityBubble()
			
func _on_body_exited(body):
	if body is Ore:
		body.exitedGravityBubble()
		
