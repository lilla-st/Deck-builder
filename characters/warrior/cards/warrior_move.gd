extends Card

func apply_effects(targets: Array[Node]) -> void:
	var effect := AddPointsEffect.new()
	effect.amount = 2
	effect.stat = AddPointsEffect.Stat.MOVEMENT
	effect.execute(targets)
