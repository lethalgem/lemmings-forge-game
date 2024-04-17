class_name GravityBubble
extends Node2D

func _on_body_entered(body):
	if body is Ore:
		body.enteredGravityBubble()

func _on_body_exited(body):
	if body is Ore:
		body.exitedGravityBubble()
