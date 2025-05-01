extends Control

@onready var v_slider: VSlider = $VSlider




func _process(delta: float) -> void:
	if GAME.is_driving:
		if Input.is_action_just_pressed("scrollup"):
			v_slider.value += 1.0
		if Input.is_action_just_pressed("scrolldown"):
			v_slider.value -= 1.0
	


func _on_button_pressed() -> void:
	if !GAME.is_tank_broked:
		Input.action_press("e")


func _on_button_2_pressed() -> void:
	$"../CharacterBody3D".takebazooka()
	hide()
