extends InteractComponent
class_name PickupComponent

@export var itemToPickup: Item

func do(player_data: PlayerData):
	print("Picked up: " + itemToPickup.name)
	player_data.inventory.append(itemToPickup)
