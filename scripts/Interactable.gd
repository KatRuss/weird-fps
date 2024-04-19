extends StaticBody3D

@export var interactable_name: String = "[[UNAMED OBJECT]]"
@export var interact_actions: Node
@export var player_data: PlayerData

var can_interact = false

func _on_input_event(camera, event, position, normal, shape_idx):
	# Get distance between object and main camera
	if event is InputEventMouseMotion:
		var distance = global_position.distance_to(get_viewport().get_camera_3d().global_position)
		if distance <= 4:
			can_interact = true
			player_data.looking_at = interactable_name
		else:
			can_interact = false
			player_data.looking_at = ""
	if event is InputEventMouseButton:
		if event.pressed and can_interact:
			for action in interact_actions.get_children():
				action.do(player_data)

func _on_mouse_exited():
	can_interact = false
	player_data.looking_at = ""
