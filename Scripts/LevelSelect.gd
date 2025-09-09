extends CenterContainer

# This will be an array of all the level names, we have to manually add them to this array but that's ok, it's not like we have 100+ levels...
# If there is A LOT OF LEVELS we will automate this :)
var levelNames: Array[String] = [
	"TestLevel",
]


func _ready() -> void:
	# Creates all the buttons to access the specific levels
	for level in levelNames:
		# Add level creation
		print(level)
