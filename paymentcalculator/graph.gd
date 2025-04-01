## Draws graph and contains functions to draw lines on it
class_name Graph
extends Node2D
##How do I hide this? DO NOT EDIT axis_name_space!!!!!
@onready var axis_name_space: float = (get_viewport_rect().size.y - get_viewport_rect().position.y) * 0.1
const LINE_COUNT: int = 10
const BASE_COLOR = [0.459, 0.502, 0.204, 1]

func _ready() -> void:
	# x and y axis
	var line = Line2D.new()
	line.set_y_sort_enabled(true)
	line.set_z_index(1)
	line.set_points(PackedVector2Array([Vector2(axis_name_space, get_viewport_rect().position.y), Vector2(axis_name_space, get_viewport_rect().size.y - axis_name_space), Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y - axis_name_space)]))
	line.set_default_color(Color(BASE_COLOR[0], BASE_COLOR[1], BASE_COLOR[2], BASE_COLOR[3]))
	add_child(line)
	# lines in graph
	_draw_lines(LINE_COUNT)
	
func _draw_lines(amount: int) -> void:
	var x_spacing = (get_viewport_rect().size.x - axis_name_space) / amount
	var y_spacing = (get_viewport_rect().size.y - axis_name_space) / amount
	# vertical lines
	var offset: float
	for i in range (0, amount - 1, 1):
		offset = x_spacing * (i + 1)
		_make_thin_line(PackedVector2Array([Vector2(axis_name_space + offset, get_viewport_rect().size.y - axis_name_space), Vector2(axis_name_space + offset, get_viewport_rect().position.y)]), Color(BASE_COLOR[0] / 2, BASE_COLOR[1] / 2, BASE_COLOR[2] / 2, BASE_COLOR[3]), 0.3)
	# horizontal lines
	for i in range (0, amount - 1, 1):
		offset = y_spacing * (i + 1)
		_make_thin_line(PackedVector2Array([Vector2(axis_name_space, get_viewport_rect().size.y - offset - axis_name_space), Vector2(get_viewport_rect().size.x, get_viewport_rect().size.y - offset - axis_name_space)]), Color(BASE_COLOR[0] / 2, BASE_COLOR[1] / 2, BASE_COLOR[2] / 2, BASE_COLOR[3]), 0.3)

##Makes thin lines to graph with. color and girth editable
func _make_thin_line(points: PackedVector2Array, color: Color, girth: float) -> void:
	var line = Line2D.new()
	line.set_y_sort_enabled(true)
	line.set_default_color(color)
	var a = points[1].x - points[0].x # trig
	var o = points[1].y - points[0].y # trig
	var height: float = sqrt(_squared(a) + _squared(o))
	line.set_points(PackedVector2Array([Vector2(0.0, 0.0), Vector2(0.0, -height)]))
	line.scale.x = girth
	line.position = points[0]
	line.rotation = atan2(o, a) + (0.5 * PI) # lines skewing the wrong way? check this out. Works perfectly fine for the background graph lines though
	add_child(line)

func _squared(n: float) -> float:
	return (n * n)
