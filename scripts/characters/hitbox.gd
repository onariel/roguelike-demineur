extends Area2D
class_name hitbox

var damage : float
var knockback : float

func get_damage() -> float:
	return damage
	
func get_knockback() -> float:
	return knockback

func set_damage(new_damage :float) -> void:
	damage = new_damage

func set_knockback(new_knockback) -> void:
	knockback = new_knockback
