extends Control

@onready var barra_combustivel: ProgressBar = $CanvasLayer/ControlPanel/TextureRect/ProgressBar


func setup_combustivel(max_combustivel: float):
	if barra_combustivel:
		barra_combustivel.max_value = max_combustivel
		barra_combustivel.value = max_combustivel

func atualizar_combustivel(novo_combustivel: float):
	if barra_combustivel:
		barra_combustivel.value = novo_combustivel
		
		# Muda cor conforme o combustível diminui
		var percentual = novo_combustivel / barra_combustivel.max_value
		if percentual < 0.3:
			barra_combustivel.modulate = Color.RED
		elif percentual < 0.6:
			barra_combustivel.modulate = Color.YELLOW
		else:
			barra_combustivel.modulate = Color.GREEN
