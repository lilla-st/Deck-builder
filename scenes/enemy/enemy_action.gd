class_name EnemyAction
extends Node

@export var intent: Intent

var enemy: Enemy
var target: Node2D

func is_performable() -> bool:
	return false
	
func perform_action() -> void:
	pass
