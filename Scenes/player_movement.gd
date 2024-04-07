extends Node

signal add_segment()
signal set_facing(facing: Vector2)
signal move()

@export var controls: Array[Key] = [KEY_A, KEY_S, KEY_W, KEY_D]

func _on_ticker_timeout():
	move.emit()

func _unhandled_input(event):
	if event is InputEventKey:
		if not event.pressed: return
		if event.keycode == controls[0]:
			set_facing.emit(Vector2(-1.0, 0.0))
		elif event.keycode == controls[1]:
			set_facing.emit(Vector2(0.0, 1.0))
		elif event.keycode == controls[2]:
			set_facing.emit(Vector2(0.0, -1.0))
		elif event.keycode == controls[3]:
			set_facing.emit(Vector2(1.0, 0.0))
