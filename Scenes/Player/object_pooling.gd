extends Node2D

const TIRO_SCENE = preload("uid://ds643wvcsb6yb")
@onready var spawn_tiro: Marker2D = $SpawnTiro

var can_shoot = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("atirar") && can_shoot:
		var tiro = TIRO_SCENE.instantiate()
		tiro.global_position = spawn_tiro.global_position
		get_tree().root.add_child(tiro)
		tiro.tree_exited.connect(on_tiro_destroyed)
		can_shoot = false

func on_tiro_destroyed():
	can_shoot = true
