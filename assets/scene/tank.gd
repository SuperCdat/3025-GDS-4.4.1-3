extends VehicleBody3D



@onready var v_slider: VSlider = $"../UI/VSlider"

func _physics_process(delta: float) -> void:
	
	
	if GAME.is_driving:
		steering = move_toward(steering, Input.get_axis("ui_right", "ui_left"), delta * 10)
		engine_force = v_slider.value * 150.0
		
		if Input.is_action_just_pressed("ui_accept"):
			var bullet: RigidBody3D = preload("res://assets/scene/bullet.tscn").instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			bullet.position = $tank/head/tankgun/Cylinder_007/Node3D.global_position
			bullet.transform.basis = $tank/head/tankgun.global_transform.basis
			bullet.apply_impulse(bullet.transform.basis * Vector3(.0, .0, 130.0))
			$"../Map/BulletSpace".add_child(bullet)
			await get_tree().create_timer(5.0).timeout
			bullet.queue_free()
	else:
		engine_force = .0
