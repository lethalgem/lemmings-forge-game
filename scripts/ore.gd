class_name Ore
extends CharacterBody2D

@onready var current_direction = Vector2(1,0)
@onready var current_velocity = 10

func _physics_process(delta):
	var new_position = global_position + (current_direction * current_velocity * delta)
	create_tween().tween_property(self, "global_position", new_position, delta)
