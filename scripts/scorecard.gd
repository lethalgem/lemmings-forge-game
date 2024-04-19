class_name Scorecard
extends Control

@export var default_score = 0.00

@onready var score_container: Control = %ScoreContainer
@onready var copy_button: Button = %CopyButton
@onready var level_1_score_label: Label = %Level1TimeLabel
@onready var level_2_score_label: Label = %Level2TimeLabel
@onready var level_3_score_label: Label = %Level3TimeLabel
@onready var level_4_score_label: Label = %Level4TimeLabel
@onready var level_5_score_label: Label = %Level5TimeLabel
@onready var level_6_score_label: Label = %Level6TimeLabel
@onready var level_7_score_label: Label = %Level7TimeLabel
@onready var level_8_score_label: Label = %Level8TimeLabel
@onready var level_9_score_label: Label = %Level9TimeLabel
@onready var level_10_score_label: Label = %Level10TimeLabel
@onready var level_11_score_label: Label = %Level11TimeLabel
@onready var level_12_score_label: Label = %Level12TimeLabel
@onready var level_13_score_label: Label = %Level13TimeLabel
@onready var level_14_score_label: Label = %Level14TimeLabel
@onready var level_15_score_label: Label = %Level15TimeLabel
@onready var level_16_score_label: Label = %Level16TimeLabel
@onready var level_17_score_label: Label = %Level17TimeLabel
@onready var level_18_score_label: Label = %Level18TimeLabel

@onready var scores = {1: level_1_score_label,
2: level_2_score_label,
3: level_3_score_label,
4: level_4_score_label,
5: level_5_score_label,
6: level_6_score_label,
7: level_7_score_label,
8: level_8_score_label,
9: level_9_score_label,
10: level_10_score_label,
11: level_11_score_label,
12: level_12_score_label,
13: level_13_score_label,
14: level_14_score_label,
15: level_15_score_label,
16: level_16_score_label,
17: level_17_score_label,
18: level_18_score_label}


var is_open: bool = false:
	set(value):
		score_container.visible = value
		is_open = value
	get:
		return is_open

func _ready():
	for label in scores.values():
		label.text = str(default_score).pad_decimals(2) + " sec"

func update_scorecard(level_id: int, time_sec: float):
	scores[level_id].text = str(time_sec).pad_decimals(2) + " sec"

func _on_open_close_button_button_up():
	copy_button.text = "Copy to clipboard"
	is_open = not is_open

func _on_copy_button_button_up():
	var text_to_copy = "Check out my fastest level times! Can you beat them?\n"
	for level_id in scores:
		var time = scores[level_id].text
		var text_to_append = "Level " + str(level_id) + ": No score" +"\n"
		if time != str(default_score).pad_decimals(2) + " sec":
			text_to_append = "Level " + str(level_id) + ": " + time +"\n"
		text_to_copy = text_to_copy + text_to_append
	DisplayServer.clipboard_set(text_to_copy)
	copy_button.text = "Copied"

func _on_win():
	score_container.visible = true
