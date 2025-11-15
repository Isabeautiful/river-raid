extends Area2D

const speed: float = 800

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("atiravel"):
		body.queue_free()  # Destroi o objeto
		queue_free()       # Destroi o tiro

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("atiravel"):
		area.queue_free()  # Destroi a estação
		queue_free()       # Destroi o tiro
