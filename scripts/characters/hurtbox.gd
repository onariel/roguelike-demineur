extends Area2D
class_name hurtbox

var max_health : float
var current_health : float

func set_health(health):
	max_health = health
	set_to_full_life()

func set_to_full_life() -> void:
	current_health = max_health

func take_damage(damage :float) -> void:
	print(current_health, damage)
	current_health -= damage


func _on_area_entered(area: Area2D) -> void:
	print("test")
	if area is hitbox:
		take_damage(area.get_damage())
