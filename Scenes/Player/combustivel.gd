extends Node

var max_power = 100
var min_power = 0
var current = 100
@onready var decremento: Timer = $Decremento
@onready var incremento: Timer = $Incremento
@onready var game_ui: Control = $"../Camera/Game UI"

# Variáveis de consumo
var consumo_normal: float = 1.0  # Consumo base por segundo
var consumo_acelerado: float = 5.0  # Consumo quando acelerando (5x)
var esta_acelerando: bool = false

func _ready() -> void:
	current = max_power
	game_ui.setup_combustivel(max_power)

func _on_incremento_timeout() -> void:
	if current < max_power:
		current += 1
		game_ui.atualizar_combustivel(current)  

func _on_decremento_timeout() -> void:
	var taxa_consumo = consumo_normal
	if esta_acelerando:
		taxa_consumo = consumo_acelerado
	
	if current > min_power:  
		current -= taxa_consumo
		game_ui.atualizar_combustivel(current)  
	
	if current <= 0:
		(get_parent() as CharacterBody2D).explode()

# Função para o player comunicar quando está acelerando
func set_acelerando(acelerando: bool):
	esta_acelerando = acelerando
