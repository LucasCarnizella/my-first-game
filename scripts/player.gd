extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var is_dead: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle animation overlap on death
	if not is_dead:
		# Get the input direction
		var direction := Input.get_axis("ui_left", "ui_right")

		# Handle jump
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Handle running animation
		if direction:
			sprite.play("run")
			# Change sprite direction
			sprite.flip_h = velocity.x < 0
			velocity.x = direction * SPEED
		# Handle idle animation
		else:
			sprite.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			

	move_and_slide()

func die() -> void:
	# Handle death animation
	if not is_dead:
		is_dead = true
		velocity = Vector2.ZERO
		sprite.play("death")
