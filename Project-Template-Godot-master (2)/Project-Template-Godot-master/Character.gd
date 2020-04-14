extends KinematicBody

var Bullet = preload("res://Bullet.tscn")

var gravity = Vector3.DOWN * 12
var speed = 4
var jump_speed = 6 
var spin = 0.1
var velocity = Vector3()
var jump = false
var can_move = true

func _physics_process(delta):
	velocity += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
	if jump and is_on_floor():
		velocity.y = jump_speed
		
func get_input():
	if !can_move:
		return
	var vy = velocity.y
	velocity = Vector3()
	if Input.is_action_pressed("move_forward"):
		if is_on_floor() and !$RayCast.is_colliding():
			pass
		else:
			velocity += -transform.basis.z * speed
	if Input.is_action_pressed("move_backwards"):
		velocity -= -transform.basis.z * speed
	if Input.is_action_pressed("move_right"):
		velocity -= -transform.basis.x * speed
	if Input.is_action_pressed("move_left"):
		velocity += -transform.basis.x * speed
	velocity.y = vy
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true
		
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-lerp(0, spin, event.relative.x/10))
	if event.is_action_pressed("shoot"):
		var b = Bullet.instance()
		b.start($Position3D.global_transform)
		get_parent().add_child(b)


func take_damage():
	velocity *= -1
	velocity.y = jump_speed
	can_move = false
	yield(get_tree().create_timer(1), "timeout")
	can_move = true
