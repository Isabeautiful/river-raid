extends Area2D

@export var quantidade_combustivel: float = 50.0  # Quantidade de combustível que este posto fornece

func _on_body_entered(body: Node2D) -> void:
	# Verifica se é o player
	if body as CharacterBody2D:
		# Tenta acessar o sistema de combustível do player
		var combustivel_node = body.get_node("Combustivel")  # Ajuste o caminho se necessário
		if combustivel_node and combustivel_node.has_method("reabastecer"):
			combustivel_node.reabastecer(quantidade_combustivel)
		else:
			print("Erro: Não foi possível acessar o sistema de combustível do player")
