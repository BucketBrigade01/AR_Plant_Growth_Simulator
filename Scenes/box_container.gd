extends BoxContainer


func _on_button_pressed():
	$"../FileDialog".popup()


func _on_file_dialog_file_selected(path):
	var image = Image.new()
	image.load(path)
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	$Background.texture = image_texture
