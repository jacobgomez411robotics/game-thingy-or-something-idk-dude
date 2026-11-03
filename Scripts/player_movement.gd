extends CharacterBody2D
@onready var animator: AnimatedSprite2D = $animator

const RESPAWN_POSITION:Vector2 = Vector2(0,0)
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animator.play("IDLE")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		transform.x = Vector2(direction, 0)
		if is_on_floor() :animator.play("RUN")
	else:
		if is_on_floor() :animator.play("IDLE")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not is_on_floor():
		velocity += get_gravity() * delta
		animator.play("JUMP")

	move_and_slide()

func death():
		position = RESPAWN_POSITION



func _on_area_2d_body_entered(body: Node2D) -> void:
	death()
