class_name BattleUI
extends CanvasLayer

@export var char_stats: CharacterStats : set =_set_char_stats

@onready var hand: Hand = $Hand as Hand
@onready var mana_ui: ManaUI = $ManaUI as ManaUI
@onready var end_turn_button: Button = $%EndTurnButton

var awaiting_discard_confirm := false

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)
	end_turn_button.mouse_entered.connect(_on_end_turn_button_mouse_entered)
	end_turn_button.mouse_exited.connect(_on_end_turn_button_mouse_exited)

func _input(event: InputEvent) -> void:
	if awaiting_discard_confirm and event.is_action_pressed("right_mouse"):
		awaiting_discard_confirm = false
		end_turn_button.text = "End Turn"
		hand.cancel_discard_selection()

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	mana_ui.char_stats = char_stats
	hand.char_stats = char_stats

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false

func _on_end_turn_button_mouse_entered() -> void:
	if not awaiting_discard_confirm and not end_turn_button.disabled:
		end_turn_button.text = "Discard"

func _on_end_turn_button_mouse_exited() -> void:
	if not awaiting_discard_confirm:
		end_turn_button.text = "End Turn"

func _on_end_turn_button_pressed() -> void:
	if awaiting_discard_confirm:
		awaiting_discard_confirm = false
		end_turn_button.text = "End Turn"
		end_turn_button.disabled = true
		Events.discard_confirmed.emit()
	else:
		awaiting_discard_confirm = true
		end_turn_button.text = "Confirm"
		Events.player_turn_ended.emit()
