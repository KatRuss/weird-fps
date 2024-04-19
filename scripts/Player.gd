extends CharacterBody3D


@export var player_data: PlayerData
@onready var head = $Head
@onready var camera = $Head/Camera

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed: float = 0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		handle_camera(event)

func rotate_camera(event, sensitivity):
	head.rotate_y(-event.relative.x * sensitivity)
	camera.rotate_x(-event.relative.y * sensitivity)
	camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-40),deg_to_rad(40))	

func handle_camera(event):
	if player_data.is_interacting:
		rotate_camera(event, player_data.mouse_sensitivity / player_data.interact_ms_mod)
	else:
		rotate_camera(event, player_data.mouse_sensitivity)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = player_data.jump_velocity

	if Input.is_action_pressed("interact_mode") and is_on_floor():
		player_data.is_interacting = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		player_data.is_interacting = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if player_data.is_interacting:
		speed = player_data.interact_speed
	else:
		speed = player_data.base_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	var direction = (head.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	player_data.t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob(player_data.t_bob)
	move_and_slide()

func headbob(t):
	var pos = Vector3.ZERO
	pos.y = sin(t * player_data.bob_freq) * player_data.bob_amp
	pos.x = cos(t * player_data.bob_freq/2) * player_data.bob_amp
	return pos

