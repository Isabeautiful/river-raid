extends Area2D

@onready var direita: RayCast2D = $Direita
@onready var esquerda: RayCast2D = $Esquerda

var velocidade: float = 150.0
var direcao: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	mover(delta)
	verificar_colisoes()

func verificar_colisoes() -> void:
	# Verifica se o ray da direita está colidindo
	if direita.is_colliding():
		print("RayCast Direita colidiu com: ", direita.get_collider())
		direcao = Vector2.LEFT
	
	# Verifica se o ray da esquerda está colidindo
	if esquerda.is_colliding():
		print("RayCast Esquerda colidiu com: ", esquerda.get_collider())
		direcao = Vector2.RIGHT

func mover(delta: float):
	position += direcao * velocidade * delta

func _ready() -> void:
	add_to_group("atiravel")


func _on_body_entered(body: Node2D) -> void:
	if body as CharacterBody2D:
		var player = get_tree().get_first_node_in_group("player")
		player.explode()
