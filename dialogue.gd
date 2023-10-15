extends VBoxContainer

@onready var Photo: TextureRect = $Character/Photo
@onready var Name: Label = $Character/Name
@onready var Text: Label = $TextMargin/Text

var CharacterInfo
var Characters=[]

var isAnimatingText=false
var textToShow: String
var currentText: String


func showText(text):
	currentText=""
	textToShow=text
	isAnimatingText=true


func cancelTextAnimation():
	currentText=textToShow
	isAnimatingText=false
	Text.text=textToShow


func load_JSON(route):
	var file = FileAccess.open(route, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data


func _ready():
	CharacterInfo = load_JSON("res://characters.json")
	
	for id in CharacterInfo:
		Characters.append(id)

	Name.text=CharacterInfo[Characters[0]].name + " " + CharacterInfo[Characters[0]].lastName
	print("res://characters/images/" + str(Characters[0]) + "/standard.jpg")
	var image = Image.load_from_file("res://characters/images/" + str(Characters[0]) + "/standard.jpg")
	var texture = ImageTexture.create_from_image(image)
	Photo.texture = texture
	showText("Esto es una prueba...")


func _process(delta):
	if (isAnimatingText):
		var current=currentText.length()
		if current<textToShow.length():
			currentText=currentText+textToShow[current]
			Text.text=currentText
		else:
			print("text animation ended")
			isAnimatingText=false
			return
		
