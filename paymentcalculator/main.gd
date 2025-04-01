extends Node2D

func _ready() -> void:
	var interest: float = 1 + (16/1875)
	get_node("Calculator").compound_interest_with_payments(66051.40, interest, 1200.0, 100, 0.0)
