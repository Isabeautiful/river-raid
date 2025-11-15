extends Node

var max_power = 100
var min_power = 0
var current = 100.0 
@onready var decremento: Timer = $Decremento
@onready var game_ui: Control = $"../Camera/Game UI"

# Variáveis de consumo
var consumo_movimento_normal: float = 5  # 5 unidades por segundo
var consumo_acelerado: float = 10 
var estado_movimento: String = "parado"  # "parado", "movendo", "acelerando"

func _ready() -> void:
	current = max_power
	game_ui.setup_combustivel(max_power)
	#Timer mais suavea
	decremento.wait_time = 0.05

func _process(_delta: float) -> void:
	# Atualização suave da UI
	if abs(current - ultimo_valor_ui) > 0.1:
		game_ui.atualizar_combustivel(current)
		ultimo_valor_ui = current

# Variáveis para suavização
var consumo_accumulator: float = 0.0
var ultimo_valor_ui: float = 100.0

func _on_incremento_timeout() -> void:
	if current < max_power:
		current += 1
		game_ui.atualizar_combustivel(current)  

func _on_decremento_timeout() -> void:
	var taxa_consumo_por_segundo = 0.0
	
	# Define a taxa de consumo baseada no estado de movimento
	match estado_movimento:
		"movendo":
			taxa_consumo_por_segundo = consumo_movimento_normal
		"acelerando":
			taxa_consumo_por_segundo = consumo_acelerado
	
	# Calcula o consumo para este frame baseado no tempo do timer
	var consumo_este_frame = taxa_consumo_por_segundo * decremento.wait_time
	
	# Aplica o consumo
	if current > min_power and consumo_este_frame > 0:  
		current = max(min_power, current - consumo_este_frame)
	
	if current <= 0:
		(get_parent() as CharacterBody2D).explode()

# Função para o player comunicar seu estado de movimento
func set_estado_movimento(estado: String):
	estado_movimento = estado
	
# Nova função para reabastecer
func reabastecer(quantidade: float):
	current = min(max_power, current + quantidade)
	# Força atualização imediata da UI
	game_ui.atualizar_combustivel(current)
	ultimo_valor_ui = current
	print("Combustível reabastecido: ", current, "/", max_power)
