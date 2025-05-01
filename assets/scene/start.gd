extends Node3D



func _on_button_4_pressed() -> void:
	get_tree().quit()




func _on_button_3_pressed() -> void:
	$startmenu/Button3.text = "Ko biết"


func _on_button_2_pressed() -> void:
	$startmenu/Button2.text = "Bấm cách để bắn"


func _on_button_pressed() -> void:
	hide()
	$Camera3D.current = false
	$"../CharacterBody3D/SpringArm3D/Camera3D".current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		$"../UI/Virtual Joystick".show()
	queue_free()
