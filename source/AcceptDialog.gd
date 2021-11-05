extends AcceptDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AcceptDialog_confirmed():
	get_tree().quit()


func _on_AcceptDialog_popup_hide():
	get_tree().quit()
