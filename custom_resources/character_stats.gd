class_name CharacterStats
extends Stats

@export var starting_deck : CardPile
@export var cards_per_turn: int
@export var max_aquam: int # currently only for aquam, create rest later
#@export var max_auram: int
#@export var max_corpus: int
#@export var max_herbam: int
#@export var max_ignem: int
#@export var max_terram: int
#@export var max_mentem: int

var aquam: int : set = set_aquam
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func set_aquam(value: int) -> void:
	aquam = value
	stats_changed.emit()
	
func reset_mana() -> void:
	self.aquam = max_aquam # create for other elements
	
func can_play_card(card: Card) -> bool:
	return aquam >= card.cost 
	
func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
