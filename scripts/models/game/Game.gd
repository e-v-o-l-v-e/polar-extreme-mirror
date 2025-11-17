extends Node2D

func _ready():
	GameController.set_grid(%WorldGrid)
	


func _on_button_4_pressed() -> void:
	UiController.emit_start_delete_object()
