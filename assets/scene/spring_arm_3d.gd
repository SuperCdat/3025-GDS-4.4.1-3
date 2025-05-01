extends SpringArm3D


@onready var tankgun: Node3D = $"../../head/tankgun"
@onready var head: Node3D = $"../../head"
@onready var headr: Node3D = $".."


const mousesens: float = .03

#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if GAME.is_driving:
		if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			headr.rotate_y(-event.relative.x * mousesens)
			headr.rotation.y = clamp(headr.rotation.y, deg_to_rad(-120), deg_to_rad(100))
			rotate_x(event.relative.y * mousesens)
			rotation.x = clamp(rotation.x, deg_to_rad(-10), deg_to_rad(15))
			
		
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if GAME.is_driving:
		tankgun.rotation.x = lerp(tankgun.rotation.x, deg_to_rad(rad_to_deg(-rotation.x) - 20), .01)
		tankgun.rotation.x =  clamp(tankgun.rotation.x, deg_to_rad(-41), deg_to_rad(10))
		head.rotation.y = lerp(head.rotation.y, headr.rotation.y, .01)
