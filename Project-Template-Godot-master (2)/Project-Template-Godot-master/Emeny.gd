extends KinematicBody

var target 
export var speed = 150

func _process(delta):
	if target:
		look_at(target.global_transform.origin, Vector3.UP)
		move_to_target(delta)


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
	print(body.name + " entered")
	
	
func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
	print(body.name + " exited")
	
func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)

