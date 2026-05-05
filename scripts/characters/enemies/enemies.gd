extends CharacterBody2D
class_name enemies

var health: float
var hit_verctor: Vector2

@export var knockback: float
@export var max_health: float
@export var hurtbox:hurtbox

@onready var knockback_time: Timer = $knockback_time


func take_damage(damage, pos): 
	health -= damage
	hit_verctor = pos

func _on_hurtbox_ground_take_damage(damage: float, pos : Vector2) -> void:
	take_damage(damage, pos)

func _physics_process(delta: float) -> void:
	if knockback_time.time_left > 0:
		var angle = get_angle_to(hit_verctor)
		if 0.45 <= angle and angle < 1.35:
			velocity.x = -knockback
			velocity.y = 0
		elif 1.35 <= angle and angle < 2.25:
			velocity.y = -knockback
			velocity.x = 0
		elif 2.25 <= angle and angle < 3.15:
			velocity.x = knockback
			velocity.y = 0
		else:
			velocity.y = knockback
			velocity.x = 0
