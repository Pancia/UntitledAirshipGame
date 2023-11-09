extends CharacterBody3D


@export var base_speed = 5
@export var sprint_speed = 8
@export var jump_velocity = 5.0
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
	if prev_looking_at and Input.is_action_just_released("activate"):
		print(prev_looking_at)
		var seedable = prev_looking_at.get_node("../Seedable")
		print(seedable)
		seedable.plant(Seed.randSeedKind())

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

var prev_looking_at

func _input(event):
	if event is InputEventMouseMotion:
		if !world.paused:
			parts.head.rotation_degrees.y -= event.relative.x * sensitivity
			parts.head.rotation_degrees.x -= event.relative.y * sensitivity
			parts.head.rotation.x = clamp(parts.head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
			const RAY_LENGTH = 1.5
			var space_state = get_world_3d().direct_space_state
			var cam = $head/camera
			var mousepos = get_viewport().get_mouse_position()
			var origin = cam.project_ray_origin(mousepos)
			var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
			var query = PhysicsRayQueryParameters3D.create(origin, end)
			query.collide_with_areas = true
			var result = space_state.intersect_ray(query)
			if 'collider' in result:
				var looking_at: StaticBody3D = result["collider"]
				if looking_at != prev_looking_at and prev_looking_at != null and prev_looking_at.has_method("unhighlight"):
						prev_looking_at.call("unhighlight")
				if looking_at.has_method("highlight"):
					looking_at.call("highlight")
				prev_looking_at = looking_at
			else:
				if prev_looking_at != null and prev_looking_at.has_method("unhighlight"):
						prev_looking_at.call("unhighlight")
				prev_looking_at = null
	if prev_looking_at and event.is_action_released("break"):
		#TODO should invoke the blocks' destroy method
		#so it can cleanup and do anything special (like red block)
		prev_looking_at.queue_free()
		prev_looking_at = null

func _on_pause():
	pass

func _on_unpause():
	pass

