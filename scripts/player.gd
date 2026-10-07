extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		# Handle running animation
		velocity.x = direction * SPEED
		sprite.play("run")

		# Handle sprite direction when running
		if velocity.x != 0:
			sprite.flip_h = velocity.x < 0

	else:
		# Handle idle animation
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")

	move_and_slide()
