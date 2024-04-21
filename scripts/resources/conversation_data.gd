extends Resource
class_name ConversationData

@export var lines: Array[Line]
@export var randomisedLines: bool
@export var lockPlayerUntilEndOfConv: bool

var index: int = 0

func randomiseIndex():
	var line_found = false
	while !line_found:
		var new_line = randi_range(0,len(lines)-1)
		if new_line != index:
			index = new_line
			line_found = true

func advanceIndex():
	if randomisedLines:
		randomiseIndex()
	else:
		index += 1
