class_name AddPointsEffect
extends Effect

enum Stat {BLOCK, MOVEMENT}

var amount := 0
var stat: Stat = Stat.BLOCK

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		match stat:
			Stat.BLOCK:
				if target is Enemy or target is Player:
					target.stats.block += amount
			Stat.MOVEMENT:
				if target is Player:
					target.stats.movement_points += amount
