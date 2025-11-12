extends Node

var max_power = 100
var min_power = 0
var current = 100
@onready var decremento: Timer = $Decremento
@onready var incremento: Timer = $Incremento
@onready var game_ui: Control = $"../Camera/Game UI"

func _ready() -> void:
	current = max_power
	game_ui.setup_combustivel(max_power)

func _on_incremento_timeout() -> void:
	if current < max_power:
		current += 1
		game_ui.atualizar_combustivel(current)  

func _on_decremento_timeout() -> void:
	if current > min_power:  
		current -= 1
		game_ui.atualizar_combustivel(current)  
	
	if current <= 0:
		(get_parent() as CharacterBody2D).explode()
