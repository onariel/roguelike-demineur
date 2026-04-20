extends Area2D
class_name hurtbox

signal take_damage(damage)

func _on_area_entered(area: Area2D) -> void:
	if area is hitbox:
		take_damage.emit(area.get_damage())
