extends Spatial



func _on_spikes_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
