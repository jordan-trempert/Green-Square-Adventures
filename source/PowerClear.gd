extends Sprite



func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "player":
		body.speed = 450
		body.jump_speed = -1250
		body.gravity = 4000
		self.queue_free()
