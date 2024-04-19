extends TextureRect

@export var playerData: PlayerData

@onready var cursor_label = $CursorLabel
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerData.is_interacting:
		position = get_global_mouse_position() - (size / 2)
		visible = true
		if playerData.looking_at != "":
			cursor_label.text = playerData.looking_at
		else:
			cursor_label.text = ""
	else:
		visible = false
