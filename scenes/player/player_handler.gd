class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var character: CharacterStats

func start_battle(char_stats: CharacterStats) -> void:
	character = char_stats
	character.draw_pile = character.deck.duplicate(true)
	character.draw_pile.shuffle()
	character.discard = CardPile.new()
	start_turn()
	
func start_turn() -> void:
	character.block = 0
	character.reset_mana()
	draw_cards(maxi(character.cards_per_turn - hand.get_child_count(), 0))
	
func end_turn() -> void:
	hand.begin_discard_selection()
	
func confirm_discard() -> void:
	discard_marked_cards()
	hand.end_discard_selection()
	
func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(character.draw_pile.draw_card())
	
func draw_cards(amount: int) -> void:
	if amount <= 0:
		Events.player_hand_drawn.emit()
		return

	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func(): Events.player_hand_drawn.emit()
	)

func discard_marked_cards() -> void:
	var marked := hand.get_marked_for_discard()
	if marked.is_empty():
		Events.player_hand_discarded.emit()
		return

	var tween := create_tween()
	for card_ui in marked:
		tween.tween_callback(character.discard.add_card.bind(card_ui.card))
		tween.tween_callback(hand.discard_card.bind(card_ui))
		tween.tween_interval(HAND_DISCARD_INTERVAL)

	tween.finished.connect(
		func(): Events.player_hand_discarded.emit()
	)

func reshuffle_deck_from_discard() -> void:
	if not character.draw_pile.empty():
		return
		
	while not character.discard.empty():
		character.draw_pile.add_card(character.discard.draw_card())
	
	character.draw_pile.shuffle()
