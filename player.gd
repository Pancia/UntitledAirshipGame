extends CharacterBody3D


@export var base_speed = 5
@export var sprint_speed = 8
@export var jump_velocity = 4
@export var sensitivity = 0.1
@export var accel = 10
var speed = base_speed
var sprinting = false
var camera_fov_extents = [75.0, 85.0] #index 0 is normal, index 1 is sprinting
var current_cube = null

@onready var parts = {
	"head": $head,
	"camera": $head/camera,
	#"camera_animation": $head/camera/camera_animation
}
@onready var world = get_parent()

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	world.pause.connect(_on_pause)
	world.unpause.connect(_on_unpause)
	parts.camera.current = true

func _process(delta):
	if Input.is_action_pressed("move_sprint"):
		sprinting = true
		speed = sprint_speed
		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[1], 10*delta)
	else:
		sprinting = false
		speed = base_speed
		parts.camera.fov = lerp(parts.camera.fov, camera_fov_extents[0], 10*delta)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		if current_cube.kind == "JUMP": 
			velocity.y = jump_velocity * 3
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = input_dir.normalized().rotated(-parts.head.rotation.y)
	direction = Vector3(direction.x, 0, direction.y)
	velocity.x = lerp(velocity.x, direction.x * speed, accel * delta)
	velocity.z = lerp(velocity.z, direction.z * speed, accel * delta)
	move_and_slide()
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var body = collision.get_collider()
		current_cube = body

func _input(event):
	if event is InputEventMouseMotion:
		if !world.paused:
			parts.head.rotation_degrees.y -= event.relative.x * sensitivity
			parts.head.rotation_degrees.x -= event.relative.y * sensitivity
			parts.head.rotation.x = clamp(parts.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _on_pause():
	pass

func _on_unpause():
	pass

