extends Area2D

@export var direcao: Vector2 = Vector2.RIGHT
var velocidade: float = 200.0

func _physics_process(delta: float) -> void:
	mover(delta)

func _ready() -> void:
	add_to_group("atiravel")

func mover(delta: float):
	position += direcao * velocidade * delta

func _on_body_entered(body: Node2D) -> void:
	if body as CharacterBody2D:
		var player = get_tree().get_first_node_in_group("player")
		player.explode()
