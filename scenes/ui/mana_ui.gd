class_name ManaUI
extends Panel

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var aquam_label: Label = $ManaBoxes/AquamBox/AquamLabel
@onready var auram_label: Label = $ManaBoxes/AuramBox/AuramLabel
@onready var corpus_label: Label = $ManaBoxes/CorpusBox/CorpusLabel
#@onready var herbam_label: Label = $ManaBoxes/HerbamBox/HerbamLabel
@onready var ignem_label: Label = $ManaBoxes/IgnemBox/IgnemLabel
@onready var terram_label: Label = $ManaBoxes/TerramBox/TerramLabel
#@onready var mentem_label: Label = $ManaBoxes/MentemBox/MentemLabel

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
