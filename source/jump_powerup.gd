extends Sprite

var collect = false



func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "player" && collect == false:
		collect = true
		body.jump_speed = -1600
		body.speed = 450
		$anim.play("collect")
		#queue_free()
		
