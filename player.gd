extends CharacterBody3D


const SPEED = 3.5
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.2

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camerabase = $CameraBase

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		camerabase.rotation.x -= MOUSE_SENSITIVITY * deg_to_rad(event.relative.y * 1)
		camerabase.rotation.x = clamp(camerabase.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		rotation.y -= MOUSE_SENSITIVITY * deg_to_rad(event.relative.x * 1)

var current_cube = null

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print(current_cube.kind)
		if current_cube.kind == "JUMP":
			velocity.y = JUMP_VELOCITY * 3
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var body = collision.get_collider()
		if current_cube:
			current_cube.call("unhighlight")
		current_cube = body
		body.call("highlight")
