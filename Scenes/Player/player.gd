extends CharacterBody2D

const acceleration : float = 500
const desaceleration : float = 400
const max_speed : float = 200
const min_speed : float = 100
const aux_parada : float = 100 #variavel para o player parar de andar pra sempre

@onready var combustivel: Node = $Combustivel

func _ready() -> void:
	add_to_group("player")

#gerenciamento de score:
var score: int = 0

func aumentar_score(pontos: int):
	score += pontos
	print("Score: ", score)


func _physics_process(delta: float) -> void:
	# Collision Check
	var collision = get_last_slide_collision()
	if collision != null:
		explode()
	
	# Variáveis para detectar movimento
	var movendo_horizontal = false
	var movendo_vertical = false
	var acelerando = false
	
	# Movimentacao Horizontal
	if Input.is_action_pressed("esquerda"):
		velocity.x = min(velocity.x + acceleration * delta, max_speed)
		movendo_horizontal = true
	elif Input.is_action_pressed("direita"):
		velocity.x = max(velocity.x - acceleration * delta, -max_speed)
		movendo_horizontal = true
	else:
		velocity.x = move_toward(velocity.x, 0, delta * aux_parada)
	
	# Movimentacao Vertical
	if Input.is_action_pressed("cima"):
		velocity.y = max(velocity.y - acceleration * delta, -max_speed)
		movendo_vertical = true
		acelerando = true
	elif Input.is_action_pressed("baixo"):
		velocity.y = min(velocity.y + desaceleration * delta, -min_speed)
		movendo_vertical = true
	elif velocity.y < 0:
		velocity.y = min(velocity.y + aux_parada * delta, -min_speed)
		movendo_vertical = true
	
	# Determina o estado de movimento para o sistema de combustível
	var estado = "parado"
	if movendo_horizontal or movendo_vertical:
		estado = "movendo"
	if acelerando:
		estado = "acelerando"
	
	# Comunicar ao sistema de combustível
	if combustivel:
		combustivel.set_estado_movimento(estado)
	
	move_and_slide()

func explode():
	print("Explode")
	get_tree().quit()
