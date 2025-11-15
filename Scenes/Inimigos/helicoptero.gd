extends Area2D

func _ready() -> void:
	add_to_group("atiravel")


func _on_body_entered(body: Node2D) -> void:
	if body as CharacterBody2D:
		var player = get_tree().get_first_node_in_group("player")
		player.explode()
