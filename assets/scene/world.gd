extends Node3D



@onready var player_2: Node3D = $player2
@onready var animation_player: AnimationPlayer = $player2/AnimationPlayer
@onready var ray_cast_3d: RayCast3D = $CharacterBody3D/SpringArm3D/RayCast3D

var should_look: bool = false

func _ready() -> void:
	animation_player.play("rigAction")
func _process(delta: float) -> void:
	if should_look:
		player_2.look_at(Vector3($CharacterBody3D.position.x, 0, $CharacterBody3D.position.z), Vector3.UP, true)

	
	
	if ray_cast_3d.is_colliding() && ray_cast_3d.get_collider() == $Tank && !GAME.is_driving:
		if OS.get_name() == "Android" or OS.get_name() == "iOS":
			$UI/Button.show()
		else:
			$UI/tip.show()
			$UI/tip.text = "E"
	
		
		if Input.is_action_just_pressed("e") && !GAME.is_tank_broked:
			$UI/tip.hide()
			$"UI/Virtual Joystick".hide()
			$UI/Button.hide()
			GAME.is_driving = true
			$CharacterBody3D/SpringArm3D/Camera3D.current = false
			$Tank/tank/headr/SpringArm3D/Camera3D.current = true
			$UI/Control.show()
			$UI/VSlider.show()
			if OS.get_name() == "Android" or OS.get_name() == "iOS":
			#if OS.get_name() == "Windows" or OS.get_name() == "iOS":
				$UI/Control/TouchScreenButton3.show()
			
	else:
		$UI/tip.hide()
		$UI/Button.hide()
		

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == $CharacterBody3D:
		animation_player.stop()
		$player2/rig.hide()
		$player2/Cube.show()
		should_look = true


func _on_area_3d_2_body_entered(body: Node3D) -> void:
	$WorldEnvironment.environment = preload("res://assets/map/night.tres")
	$CharacterBody3D/SpringArm3D/Camera3D.far = 50.0


func _on_area_3d_3_body_entered(body: Node3D) -> void:
	if body == $Tank:
		GAME.is_tank_broked = true
		$Tank/CPUParticles3D.show()
		$Tank/CPUParticles3D.emitting = true
		GAME.is_driving = false
		$UI/Control/TouchScreenButton3.hide()
		$UI/VSlider.hide()
		await get_tree().create_timer(4.0).timeout
		if OS.get_name() == "Android" or OS.get_name() == "iOS":
			$"UI/Virtual Joystick".show()
		$CharacterBody3D/SpringArm3D/Camera3D.current = true
		$Tank/tank/headr/SpringArm3D/Camera3D.current = false
		$UI/Control.hide()
		$CharacterBody3D.position = $Tank.position - Vector3(10, -3, 0)
		await get_tree().create_timer(5.0).timeout
		$Tank/CPUParticles3D.hide()
		$Tank/CPUParticles3D.emitting = false
