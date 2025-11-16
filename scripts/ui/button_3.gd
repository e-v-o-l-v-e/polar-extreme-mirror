extends Button


func _on_pressed() -> void:
	UiController.emit_enroll_scientist()
