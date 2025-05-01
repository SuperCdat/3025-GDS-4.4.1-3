extends Node3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	$Sprite3D/AnimationPlayer.play("die")

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	$Sprite3D2/AnimationPlayer.play("die")

func _on_area_3d_3_body_entered(body: Node3D) -> void:
	$Sprite3D3/AnimationPlayer.play("die")
