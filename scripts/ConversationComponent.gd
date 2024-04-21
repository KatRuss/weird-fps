extends InteractComponent
class_name ConversationComponent

@export var characterName: String
@export var conversations: Array[ConversationData]
var index = 0

func do(playerData: PlayerData):
	if index < len(conversations):
		if advance_line(conversations[index]):
			index += 1
	else:
		print("No more Conversations") # Divert to some "I have nothing else to say line"

func advance_line(data: ConversationData) -> bool:
	if data.index < len(data.lines):
		var speaker = ""
		if data.lines[data.index].player_is_speaker:
			speaker = "Player: "
		else:
			speaker = characterName + ": "
		print(speaker + data.lines[data.index].text)
		data.advanceIndex()
		return false # Still more lines to run
	else:
		print("No more lines")
		return true
