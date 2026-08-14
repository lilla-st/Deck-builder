class_name EnemyActionPicker
extends Node

@export var enemy: Enemy: set = _set_enemy
@export var target: Node2D: set = _set_target

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")

func _set_enemy(value: Enemy) -> void:
	enemy = value

	for action in get_children():
		if action is EnemyAction:
			action.enemy = enemy

func _set_target(value: Node2D) -> void:
	target = value

	for action in get_children():
		if action is EnemyAction:
			action.target = target

func get_action() -> EnemyAction:
	for action in get_children():
		if action is EnemyAction and action.is_performable():
			return action
	return null
