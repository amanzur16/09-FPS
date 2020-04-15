extends Label

var coins = 0

func _ready():
	text = String(coins)


func _on_CoinGold_CoinCollected():
	coins = coins + 1
	text = String(coins)
	if coins == 27:
		$Timer.start()


func _on_Timer_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene("res://You_Win.tscn")
