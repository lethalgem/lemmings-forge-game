extends RichTextLabel

signal finished_displaying_text

@export var text_speed_secs = 3

@onready var continue_button = %ContinueButton
@onready var text_box = %TextBox

var text_to_display = []
var button_text = []
var is_drawing_text = false
var tween

func _ready():
	visible_ratio = 0

func queue_text(display_text: String, button_title: String):
	text_box.visible = true
	text_to_display.append(display_text)
	button_text.append(button_title)
	if not is_drawing_text:
		draw_next_text()

func draw_next_text():
	if is_drawing_text:
		print("i work?")
		visible_ratio = 1
		tween.kill()
		is_drawing_text = false
	elif text_to_display.size() > 0 and not is_drawing_text:
		is_drawing_text = true
		visible_ratio = 0
		text = text_to_display.pop_front()
		print(text)
		continue_button.text = button_text.pop_front()
		tween = create_tween()
		tween.tween_property(self, "visible_ratio", 1, text_speed_secs)
		tween.connect("finished", on_drawing_finished)
	else:
		text_box.visible = false
		emit_signal("finished_displaying_text")

func on_drawing_finished():
	is_drawing_text = false
	print("Tween done!")


func _on_continue_button_button_up():
	draw_next_text()
