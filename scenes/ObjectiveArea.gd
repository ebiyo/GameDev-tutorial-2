extends Area2D

@onready var win_label = $"../CanvasLayer/Label"

func _on_ObjectiveArea_body_entered(body: RigidBody2D):
	if (body.name == "BlueShip" || body.name == "GreenShip"):
		print("Reached objective!")
		win_label.visible = true
		get_tree().paused = true
