extends Sprite




var file = File.new()

	
func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "player":
		var level = "res://Scenes/Level_4.tscn"
		get_tree().change_scene(level)
		print(level)
		var save = File.new()
		if save.file_exists("res://save.save"):
			file.open("res://save.save", File.WRITE)
			file.store_string(level)
