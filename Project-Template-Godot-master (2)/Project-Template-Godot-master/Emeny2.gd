extends KinematicBody

var health = 200
var target 
export var speed = 150
var is_dead = false


func take_damage(d):
	health -= d
	if health <= 0:
		queue_free()



func _process(delta):
	if health <=0:
		queue_free()
	if target:
		look_at(target.global_transform.origin, Vector3.UP)
		move_to_target(delta)


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = null
	print(body.name + " entered")
	
	
func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = body
	print(body.name + " exited")
	
func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)
	
	
