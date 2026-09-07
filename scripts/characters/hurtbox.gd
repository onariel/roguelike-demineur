extends Area2D
class_name hurtbox

signal take_damage(damage, knockback_direction, knockback_force)

func _ready() -> void:
	if !area_entered.is_connected(_on_area_entered):
		connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is hitbox:
		take_damage.emit(area.get_damage(), (global_position - area.get_parent().global_position).normalized(), area.get_knockback())
