extends RigidBody2D

func _physics_process(delta):
	if global_position.y > 1000:
		global_position = Vector2(500 + randi() % 100 - 50, 0)
