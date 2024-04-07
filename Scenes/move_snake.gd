class_name SnakeMovement
extends Node2D

@export var body_segment: PackedScene

var growth_left := 0
var segments: Array[Node2D] = []
var facing := Vector2i(0, 1)

func _on_child_area_2d_area_entered(other_area: Area2D):
	if other_area.is_in_group("danger"):
		queue_free()
	elif other_area.is_in_group("safe"):
		add_segment()
	else:
		push_error("Collided without group!")

# Called when the node enters the scene tree for the first time.
func _ready():
	var child := body_segment.instantiate()
	add_child(child)
	child.get_node("Area2D").area_entered.connect(_on_child_area_2d_area_entered)
	segments.push_back(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
 
func add_segment():
	growth_left += 1

func move_segments():
	var old_pos := segments[0].position
	segments[0].position += facing * 16.0
	if growth_left > 0:
		var child := body_segment.instantiate()
		child.position = segments.back().position
		add_child(child)
		segments.push_back(child)
		growth_left -= 1
	for i in range(segments.size() - 1, 1, -1):
		segments[i].position = segments[i - 1].position
	if segments.size() > 1:
		segments[1].position = old_pos

func set_facing(movement: Vector2):
	if movement.x != 0:
		facing = Vector2i(1.0, 0.0) if movement.x > 0 else Vector2i(-1.0, 0.0)
	elif movement.y != 0:
		facing = Vector2i(0.0, 1.0) if movement.y > 0 else Vector2i(0.0, -1.0)
