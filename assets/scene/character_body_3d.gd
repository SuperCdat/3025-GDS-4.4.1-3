extends CharacterBody3D

const mousesens = .02

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var input_dir

func takebazooka() -> void:
	$"../Map/Bazooka".hide()
	$"../UI/tip".hide()
	$SpringArm3D/bazooka.show()
	GAME.did_take_bazooka = true
	$"../UI/Control".show()
	$"../UI/Control/TouchScreenButton".hide()
	$"../UI/Control/TouchScreenButton2".hide()
	$"../UI/Control/TouchScreenButton3".show()

func _input(event: InputEvent) -> void:
	if !GAME.is_driving:
		if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			$SpringArm3D.rotate_x((-event.relative.y) * mousesens)
			rotate_y((-event.relative.x) * mousesens)
			$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x, deg_to_rad(-90.0), deg_to_rad(90.0))
			

func _process(delta: float) -> void:
	if $SpringArm3D/RayCast3D.is_colliding() && $SpringArm3D/RayCast3D.get_collider() == $"../Map/Bazooka/StaticBody3D" && !GAME.did_take_bazooka:
		if OS.get_name() == "Android" or OS.get_name() == "iOS":
			$"../UI/Button2".show()
		else:
			$"../UI/tip".show()
			$"../UI/tip".text = "E"
			
			if Input.is_action_just_pressed("e"):
				takebazooka()
	else:
		$"../UI/Button2".hide()
		#$"../UI/tip".hide()
	
	if GAME.did_take_bazooka && Input.is_action_just_pressed("ui_accept") && !GAME.did_shoot_bazooka:
		GAME.did_shoot_bazooka = true
		$SpringArm3D/bazooka/Cylinder004.hide()
		var cylinder_004 : RigidBody3D = preload("res://assets/obj/cylinder_006.tscn").instantiate()
		cylinder_004.transform.basis =  $SpringArm3D/Node3D.global_transform.basis
		cylinder_004.position = $SpringArm3D/Node3D.global_position
		cylinder_004.apply_impulse(cylinder_004.transform.basis * Vector3(.0, .0, 50.0))
		$"../Map/BulletSpace".add_child(cylinder_004)
		await (get_tree().create_timer(5.0).timeout)
		if cylinder_004:
			cylinder_004.queue_free()
		
func _physics_process(delta: float) -> void:
	if !GAME.is_driving:
		velocity.y -= delta * gravity
		
		input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y).normalized()
		if direction:
			velocity.x = direction.x * 5.0
			velocity.z = direction.z * 5.0
		else:
			velocity.x = .0
			velocity.z = .0
		
		move_and_slide()
