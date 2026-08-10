extends Node

# Card events
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)
signal card_played(card: Card)
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_tooltip_requested(icon: Texture, text: String)
signal tooltip_hide_requested

#player events
signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended
signal discard_confirmed
