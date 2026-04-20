extends Area2D
class_name hitbox

var damage : float

func get_damage() -> float:
	return damage

func set_damage(new_damage :float) -> void:
	damage = new_damage
