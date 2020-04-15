extends RayCast

var current_collider

func _process(delta):
	var collider = get_collider()
	
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			
			if Input.is_action_just_pressed("Interact"):
				collider.interact()
		elif current current collider:
			current collider = null 
