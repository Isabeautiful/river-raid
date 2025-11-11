extends CharacterBody2D

const acceleration : float = 500
const desaceleration : float = 400
const max_speed : float = 200
const min_speed : float = 100

const aux_parada : float = 100 #variavel para o player parar de andar pra sempre

func _physics_process(delta: float) -> void:
	#Collision Check
	var collision = get_last_slide_collision()
	if collision != null:
		print("Explode")
		get_tree().quit()
	
	#Movimentacao Horizontal
	if Input.is_action_pressed("esquerda"):
		velocity.x = min(velocity.x + acceleration * delta, max_speed)
	elif Input.is_action_pressed("direita"):
		velocity.x = max(velocity.x - acceleration * delta, -max_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, delta * aux_parada)
	
	#Movimentacao Vertical
	if Input.is_action_pressed("cima"):
		velocity.y = max(velocity.y - acceleration * delta, -max_speed)
	elif Input.is_action_pressed("baixo"):
		velocity.y = min(velocity.y + desaceleration * delta, -min_speed)
	elif velocity.y < 0:
		velocity.y = min(velocity.y + aux_parada * delta, -min_speed)
	move_and_slide()
