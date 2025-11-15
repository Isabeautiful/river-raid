extends Node

var max_power: float = 100.0
var min_power: float = 0.0
var current: float = 100.0 
@onready var decremento: Timer = $Decremento
@onready var game_ui: Control = $"../Camera/Game UI"

# Variáveis de consumo
var consumo_movimento_normal: float = 1.0
var consumo_acelerado: float = 10.0
var estado_movimento: String = "parado"

# Variáveis para reabastecimento
var reabastecimento_ativo: bool = false
var quantidade_reabastecer: float = 0.0
var velocidade_reabastecimento: float = 30.0
var ultimo_valor_ui: float = 100.0

func _ready() -> void:
	current = max_power
	game_ui.setup_combustivel(max_power)
	decremento.wait_time = 0.05

func _process(delta: float) -> void:
	# Processa reabastecimento se estiver ativo
	if reabastecimento_ativo:
		var incremento = velocidade_reabastecimento * delta
		if quantidade_reabastecer > 0:
			var adicionar = min(incremento, quantidade_reabastecer)
			current = min(max_power, current + adicionar)
			quantidade_reabastecer -= adicionar
			
			# Atualiza a UI
			game_ui.atualizar_combustivel(current)
			ultimo_valor_ui = current
		else:
			reabastecimento_ativo = false
	
	# Atualiza a UI durante o consumo (sem reabastecimento ativo)
	elif abs(current - ultimo_valor_ui) > 0.05:
		game_ui.atualizar_combustivel(current)
		ultimo_valor_ui = current

func _on_decremento_timeout() -> void:
	# Não consome combustível durante o reabastecimento
	if reabastecimento_ativo:
		return
		
	var taxa_consumo_por_segundo = 0.0
	
	match estado_movimento:
		"movendo":
			taxa_consumo_por_segundo = consumo_movimento_normal
		"acelerando":
			taxa_consumo_por_segundo = consumo_acelerado
	
	var consumo_este_frame = taxa_consumo_por_segundo * decremento.wait_time
	
	# Aplica o consumo
	if current > min_power and consumo_este_frame > 0:  
		current = max(min_power, current - consumo_este_frame)
	
	if current <= 0:
		(get_parent() as CharacterBody2D).explode()

func set_estado_movimento(estado: String):
	estado_movimento = estado
	
func reabastecer(quantidade: float):
	reabastecimento_ativo = true
	quantidade_reabastecer = min(quantidade, max_power - current)
