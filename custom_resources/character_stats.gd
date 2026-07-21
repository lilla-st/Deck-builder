class_name CharacterStats
extends Stats

@export var starting_deck : CardPile
@export var cards_per_turn: int
@export var max_aquam: int # currently only for aquam, create rest later
@export var max_auram: int
@export var max_corpus: int
#@export var max_herbam: int
@export var max_ignem: int
@export var max_terram: int
#@export var max_mentem: int

var aquam: int : set = set_aquam
var auram: int : set = set_auram
var corpus: int : set = set_corpus
var ignem: int : set = set_ignem
var terram: int : set = set_terram
var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

func set_aquam(value: int) -> void:
	aquam = value
	stats_changed.emit()

func set_auram(value: int) -> void:
	auram = value
	stats_changed.emit()
	
func set_corpus(value: int) -> void:
	corpus = value
	stats_changed.emit()
	
func set_ignem(value: int) -> void:
	ignem = value
	stats_changed.emit()
	
func set_terram(value: int) -> void:
	terram = value
	stats_changed.emit()
	
func reset_mana() -> void:
	self.aquam = max_aquam
	self.auram = max_auram
	self.corpus = max_corpus
	self.ignem = max_ignem
	self.terram = max_terram
	
func can_play_card(card: Card) -> bool: #additional mana required
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
