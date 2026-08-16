class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats

@onready var card_ui := preload("res://scenes/card_ui.tscn")

var cards_played_this_turn := 0

func _ready() -> void:
	Events.card_played.connect(_on_card_played)
	
func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats

	if not card.is_playable():
		new_card_ui.playable = false
	
	
func _on_card_played(_card: Card) -> void:
	cards_played_this_turn += 1
	
func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

func begin_discard_selection() -> void:
	for card in get_children():
		card.in_discard_selection = true

func end_discard_selection() -> void:
	# skips cards marked for discard: they're about to be freed by
	# discard_marked_cards() and should keep their tint until then
	for card in get_children():
		if card.marked_for_discard:
			continue
		card.in_discard_selection = false

func cancel_discard_selection() -> void:
	for card in get_children():
		card.marked_for_discard = false
		card.in_discard_selection = false

func get_marked_for_discard() -> Array[CardUI]:
	var marked: Array[CardUI] = []
	for card in get_children():
		if card.marked_for_discard:
			marked.append(card)
	return marked

func get_undiscardable_cards() -> Array[CardUI]:
	var undiscardable: Array[CardUI] = []
	for card in get_children():
		if not card.card.is_discardable():
			undiscardable.append(card)
	return undiscardable

func has_playable_cards(excluding: Array[CardUI] = []) -> bool:
	for card in get_children():
		if excluding.has(card):
			continue
		if card.card.is_playable():
			return true
	return false
		
func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index - cards_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
