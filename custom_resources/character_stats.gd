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
@export var max_movement_points: int

var aquam: int : set = set_aquam
var auram: int : set = set_auram
var corpus: int : set = set_corpus
var ignem: int : set = set_ignem
var terram: int : set = set_terram
var movement_points: int : set = set_movement_points
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

func set_movement_points(value: int) -> void:
	movement_points = value
	stats_changed.emit()

func reset_mana() -> void:
	self.aquam = max_aquam
	self.auram = max_auram
	self.corpus = max_corpus
	self.ignem = max_ignem
	self.terram = max_terram
	self.movement_points = max_movement_points
	
func can_play_card(card: Card) -> bool:
	var adv := card.advanced_cost
	if adv:
		return (
			aquam >= adv.aquam and auram >= adv.auram
			and corpus >= adv.corpus and ignem >= adv.ignem
			and terram >= adv.terram
		)

	match card.cost_type:
		Card.ManaType.AQUAM: return aquam >= card.cost
		Card.ManaType.AURAM: return auram >= card.cost
		Card.ManaType.CORPUS: return corpus >= card.cost
		Card.ManaType.IGNEM: return ignem >= card.cost
		Card.ManaType.TERRAM: return terram >= card.cost
	return false

func pay_cost(card: Card) -> void:
	var adv := card.advanced_cost
	if adv:
		self.aquam -= adv.aquam
		self.auram -= adv.auram
		self.corpus -= adv.corpus
		self.ignem -= adv.ignem
		self.terram -= adv.terram
		return

	match card.cost_type:
		Card.ManaType.AQUAM: self.aquam -= card.cost
		Card.ManaType.AURAM: self.auram -= card.cost
		Card.ManaType.CORPUS: self.corpus -= card.cost
		Card.ManaType.IGNEM: self.ignem -= card.cost
		Card.ManaType.TERRAM: self.terram -= card.cost

func create_instance() -> Resource:
	var instance: CharacterStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
