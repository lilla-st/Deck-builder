extends Node2D

@export var char_stats: CharacterStats
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler


@onready var battle_ui: BattleUI = $BattleUI as BattleUI

func _ready() -> void:
	#temp code, fix later so starts with a start button to create new game
	
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.discard_confirmed.connect(player_handler.confirm_discard)
	Events.player_hand_discarded.connect(player_handler.start_turn)
	
	start_battle(new_stats)
	
func start_battle(stats: CharacterStats) -> void:
	player_handler.start_battle(stats)
