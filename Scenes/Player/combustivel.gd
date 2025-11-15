extends Node

var max_power = 100
var min_power = 0
var current = 100
@onready var decremento: Timer = $Decremento
@onready var incremento: Timer = $Incremento
@onready var game_ui: Control = $"../Camera/Game UI"

# Variáveis de consumo
var consumo_movimento_normal: float = 1.0  # Consumo quando se movendo (normalmente)
var consumo_acelerado: float = 5.0  # Consumo quando acelerando
var estado_movimento: String = "parado"  # "parado", "movendo", "acelerando"

func _ready() -> void:
	current = max_power
	game_ui.setup_combustivel(max_power)

func _on_incremento_timeout() -> void:
	if current < max_power:
		current += 1
		game_ui.atualizar_combustivel(current)  

func _on_decremento_timeout() -> void:
	var taxa_consumo = 0.0
	
	# Define a taxa de consumo baseada no estado de movimento
	match estado_movimento:
		"movendo":
			taxa_consumo = consumo_movimento_normal
		"acelerando":
			taxa_consumo = consumo_acelerado
	
	# Aplica o consumo
	if current > min_power and taxa_consumo > 0:  
		current -= taxa_consumo
		game_ui.atualizar_combustivel(current)  
	
	if current <= 0:
		(get_parent() as CharacterBody2D).explode()

# Função para o player comunicar seu estado de movimento
func set_estado_movimento(estado: String):
	estado_movimento = estado
