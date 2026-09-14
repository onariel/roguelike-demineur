extends CharacterBody2D
class_name enemies

var health: float
var hit_verctor: Vector2
const KNOCKBACK_FRICTION: float = 100

var last_knockback_direction: Vector2
var last_knockback_force: float
var is_knocked_back: bool = false
var knockback_duration: float = 0.5
var knockback_velocity := Vector2.ZERO

@export var knockback_resistance: float
@export var knockback: float
@export var max_health: float
@export var damage: float
@export var hurtbox_enemie: hurtbox

@onready var player: CharacterBody2D = get_tree().get_root().get_node("main area").get_node("player")
signal health_depleted()

func _ready() -> void:
	health = max_health
	hurtbox_enemie.take_damage.connect(_on_hurtbox_take_damage)


func take_damage(damage_taken: float, knockback_direction : Vector2, knockback_force : float) -> void:
	print(health, damage_taken)
	health -= damage_taken
	if health <= 0:
		health_depleted.emit()
	var adjusted_force = knockback_force * (1.0 - knockback_resistance)
	knockback_velocity = knockback_direction * adjusted_force
	is_knocked_back = true
	if knockback_duration > 0:
		await get_tree().create_timer(knockback_duration).timeout
		is_knocked_back = false
		velocity = Vector2.ZERO

func _on_hurtbox_take_damage(damage_taken: float, knockback_direction : Vector2, knockback_force : float) -> void:
	take_damage(damage_taken, knockback_direction, knockback_force)
