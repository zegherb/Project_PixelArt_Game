extends CharacterBody2D

var speed = 300
var last_direction = "down" 

func _physics_process(delta: float) -> void:
	var input_x = Input.get_axis("ui_left", "ui_right")
	var input_y = Input.get_axis("ui_up", "ui_down")

	velocity = Vector2(input_x, input_y).normalized() * speed

	animation(input_x, input_y)
	move_and_slide()

func animation(x: float, y: float) -> void:
	if x == 0 and y == 0:
		match last_direction:
			"up": $AnimatedSprite2D.play("idle_up")
			"down": $AnimatedSprite2D.play("idle_down")
			"side": $AnimatedSprite2D.play("idle_side")
	else:
		if abs(x) > abs(y):
			last_direction = "side"
			$AnimatedSprite2D.play("walk_side")
			$AnimatedSprite2D.flip_h = x < 0  
		else:
			if y > 0:
				last_direction = "down"
				$AnimatedSprite2D.play("walk_down")
			else:
				last_direction = "up"
				$AnimatedSprite2D.play("walk_up")
