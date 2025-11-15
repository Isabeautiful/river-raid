extends Node2D

@onready var player: CharacterBody2D = $Player

func _process(_delta: float) -> void:
	if player.score == 5:
		get_tree().change_scene_to_file("res://Scenes/UI/Menu/finish_game.tscn")
