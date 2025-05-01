extends RigidBody3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "StaticBody3D2":
		body.get_parent().explode()
	await (get_tree().create_timer(2.0).timeout)
	queue_free()
