extends Area2D

@export var target_scene_path : String
@onready var win_label = $"../CanvasLayer/Label"
@onready var restart_button = $"../CanvasLayer/RestartButton"
@onready var next_button = $"../CanvasLayer/NextButton"

func _on_ObjectiveArea_body_entered(body: RigidBody2D):
	if (body.name == "BlueShip" || body.name == "GreenShip"):
		print("Reached objective!")
		win_label.visible = true
		restart_button.visible = true
		next_button.visible = true
		get_tree().paused = true
		
func _on_restart_button_pressed():
	print("Restart pressed")
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_next_button_pressed():
	print(target_scene_path)
	get_tree().paused = false
	get_tree().change_scene_to_file(target_scene_path)
