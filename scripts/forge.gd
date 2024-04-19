class_name Forge
extends Node2D

@export var level: Level

@onready var ore = preload("res://scenes/ore.tscn")
@onready var goal_highlight = %GoalHighlight

func _on_area_2d_body_entered(body):
	if body is Ore and body._level_id == level.id:
		level.ore_absorbed()
		body.queue_free()


func _process(delta):
	rotation -= 36 * delta * PI / 180

func show_goal_highlight(should_show: bool):
	if should_show:
		goal_highlight.visible = true
	else:
		goal_highlight.visible = false
