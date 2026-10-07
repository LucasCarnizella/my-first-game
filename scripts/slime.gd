extends Node2D

const SPEED = 40

var direction = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_direct_right: RayCast2D = $RayCastDirectRight
@onready var ray_cast_ground_right: RayCast2D = $RayCastGroundRight
@onready var ray_cast_direct_left: RayCast2D = $RayCastDirectLeft
@onready var ray_cast_ground_left: RayCast2D = $RayCastGroundLeft

func _process(delta: float) -> void:
	# Handle right movement
	if direction >= 0:
		# Change direction when hitting a wall
		if ray_cast_direct_right.is_colliding():
			direction = -1

		# Change direction when ground not detected
		if not ray_cast_ground_right.is_colliding():
			direction = -1

	# Handle left movement
	elif direction < 0:
		# Change direction when hitting a wall
		if ray_cast_direct_left.is_colliding():
			direction = 1

		# Change direction when ground not detected
		if not ray_cast_ground_left.is_colliding():
			direction = 1

	# Change sprite direction
	sprite.flip_h = direction < 0

	# Change enemy position
	position.x += direction * SPEED * delta
