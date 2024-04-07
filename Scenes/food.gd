extends Sprite2D

func _on_area_2d_area_entered(area):
	position = Vector2i(randi_range(0, 31), randi_range(0, 31)) * 16.0 + Vector2(336, 72)
