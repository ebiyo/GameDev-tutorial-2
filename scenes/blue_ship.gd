extends RigidBody2D

@export var thrust_force := 900.0
@export var horizontal_force := 600.0
@export var max_speed := 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#print(linear_velocity)
	# Continuous upward thrust
	if Input.is_action_pressed("move_up"):
		apply_central_force(Vector2(0, -thrust_force))
		
	# Left / Right movement
	if Input.is_action_pressed("move_left"):
		apply_central_force(Vector2(-horizontal_force, 0))

	if Input.is_action_pressed("move_right"):
		apply_central_force(Vector2(horizontal_force, 0))
	
	#linear_velocity = linear_velocity.clamp(Vector2(-max_speed, -max_speed),
											#Vector2(max_speed, max_speed))
