extends CharacterBody2D

var health

@export var max_health: float
@export var hurtbox:hurtbox

func take_damage(damage): 
	health -= damage

func _on_hurtbox_ground_take_damage(damage: float, pos : Vector2) -> void:
	take_damage(damage)
