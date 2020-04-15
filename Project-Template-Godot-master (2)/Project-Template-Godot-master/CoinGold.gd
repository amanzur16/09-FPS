extends Area

var value = 1

signal CoinCollected


func _on_CoinGold_body_entered(body):
	queue_free()
	emit_signal("CoinCollected")
