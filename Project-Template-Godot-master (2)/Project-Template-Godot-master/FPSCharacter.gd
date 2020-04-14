extends KinematicBody

var Bullet = preload("res://Bullet.tscn")
onready var camera = $Pivot/Camera

var gravity = -20
var jump_speed = 6
var max_speed = 5
var mouse_sensitivity = 0.002 # radians/pixel

var velocity = Vector3()
var jump = false


func get_input():
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true
	
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("move_backwards"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("move_left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("move_right"):
		input_dir += camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
	
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
	if event.is_action_pressed("shoot"):
		var b = Bullet.instance()
		b.start($Position3D.global_transform)
		get_parent().add_child(b)
		

		
func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	if jump and is_on_floor():
		velocity.y = jump_speed
