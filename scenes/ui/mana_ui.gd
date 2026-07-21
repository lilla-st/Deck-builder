class_name ManaUI
extends Panel

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var aquam_label: Label = $AquamLabel
@onready var auram_label: Label = $AuramLabel
@onready var corpus_label: Label = $CorpusLabel
#@onready var herbam_label: Label = $HerbamLabel
@onready var ignem_label: Label = $IgnemLabel
@onready var terram_label: Label = $TerramLabel
#@onready var mentem_label: Label = $MentemLabel

func _ready() -> void:
	char_stats.aquam = char_stats.max_aquam

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	
	if not char_stats.stats_changed.is_connected(_on_stats_changed):
		char_stats.stats_changed.connect(_on_stats_changed)
		
	if not is_node_ready():
		await ready
	
func _on_stats_changed() -> void:
	aquam_label.text = "%s/%s" % [char_stats.aquam, char_stats.max_aquam]
	auram_label.text = "%s/%s" % [char_stats.auram, char_stats.max_auram]
	corpus_label.text = "%s/%s" % [char_stats.corpus, char_stats.max_corpus]
	ignem_label.text = "%s/%s" % [char_stats.ignem, char_stats.max_ignem]
	terram_label.text = "%s/%s" % [char_stats.terram, char_stats.max_terram]
	
