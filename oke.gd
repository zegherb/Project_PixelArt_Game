extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var flip : bool  = true
var max_jump = 2
var jump_count = 0

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor() :
		jump_count = 0
		
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0 and !flip:
		flipnya()
	if velocity.x < 0 and flip:
		flipnya()
		
	move_and_slide()
	animation()
	
func animation():
	if velocity.x != 0 and is_on_floor() :
		$AnimatedSprite2D.play("move")
	elif velocity.x == 0 and is_on_floor() :
		$AnimatedSprite2D.play("idle")
	elif velocity.y != 0 and !is_on_floor() :
		$AnimatedSprite2D.play("jump")
		
func flipnya() :
	scale.x *= -1
	flip = !flip
	
