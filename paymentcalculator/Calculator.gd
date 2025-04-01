##Calculator
class_name Calculator
extends Node

##Calculates compounding interest, accounting for monthly payments. Returns month when goal is hit and cash owned/due on that month.
func compound_interest_with_payments(principle: float, interest: float, payment: float, _target_month: int, _target_value: float) -> Vector2:
	var cash: float = principle
	var month: int = 0
	var calc_debt_or_profit: int = 0
	var targetMonth: int = INF
	var targetCash: float = INF
	
	targetCash = _target_value
	targetMonth = _target_month
	if (targetCash == INF) && (targetMonth == INF):
		targetMonth = 60
		targetCash = 0.0
	
	if principle > targetCash:
		calc_debt_or_profit = -1
	
	while ((cash * calc_debt_or_profit) < targetCash) && month < targetMonth:
		cash = (cash - payment) * interest
		month += 1
		print("Month: ", month, "\nCash Value: ", cash)
	
	return Vector2(month, cash)
