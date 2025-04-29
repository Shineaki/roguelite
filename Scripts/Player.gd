extends CharacterBody2D


const SPEED = 50.0
var Target_Position = Vector2(0, 0)
var Currently_Moving = false
var Facing_Left = false

func _physics_process(delta: float) -> void:
	#var input_velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var input_velocity = Vector2(0, 0)

	if position.distance_to(Target_Position) < 1.0 and Currently_Moving:
		# Snap to position
		position = Target_Position
		Currently_Moving = false
		return
	else:
		velocity = Vector2(0, 0)

	if Currently_Moving:
		velocity = position.direction_to(Target_Position) * SPEED
		print(position.distance_to(Target_Position))
		$AnimatedSprite2D.play("run")
	else:
		var horizontal = Input.get_axis("ui_left", "ui_right")
		if horizontal:
			Target_Position = horizontal * Vector2(16, 0) + position
			Currently_Moving = true
			velocity = position.direction_to(Target_Position) * SPEED
			$AnimatedSprite2D.flip_h = velocity.x < 0.0
			$AnimatedSprite2D.play("run")
		else:
			var vertical = Input.get_axis("ui_up", "ui_down")
			if vertical:
				Target_Position = vertical * Vector2(0, 16) + position
				Currently_Moving = true
				velocity = position.direction_to(Target_Position) * SPEED
				$AnimatedSprite2D.play("run")
			else:
				velocity = Vector2(0, 0)
				Currently_Moving = false
				$AnimatedSprite2D.play("idle")

	move_and_slide()
