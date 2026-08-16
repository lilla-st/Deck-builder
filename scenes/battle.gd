extends Node2D

@export var char_stats: CharacterStats
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player: Player = $Player as Player
@onready var enemy_handler: EnemyHandler = $EnemyHandler


@onready var battle_ui: BattleUI = $BattleUI as BattleUI

func _ready() -> void:
	#temp code, fix later so starts with a start button to create new game

	var new_stats: CharacterStats = char_stats.create_instance()
	player.stats = new_stats
	battle_ui.char_stats = new_stats
	
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.discard_confirmed.connect(player_handler.confirm_discard)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	Events.player_took_unblocked_damage.connect(player_handler.add_wounds)
	
	start_battle(new_stats)
	
func start_battle(stats: CharacterStats) -> void:
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)
	
func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()


func _on_enemy_handler_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("victory!")

func _on_player_died() -> void:
	print("game over :(")
