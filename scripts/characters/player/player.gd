extends CharacterBody2D

signal health_depleted()

const SPEED = 80.0
const KNOCKBACK_FRICTION: float = 50
var health;
var knockback = 50.0
var recovery_time_time = 0.5
var last_knockback_direction: Vector2
var last_knockback_force: float
var is_knocked_back: bool = false
var knockback_duration: float = 0.5
var knockback_velocity := Vector2.ZERO

@export var knockback_resistance: float
@export var max_health: float

@onready var hurtbox: hurtbox = $hurtbox
@onready var hurtbox_ground: hurtbox = $hurtbox_ground
@onready var recovery_time: Timer = $Recovery_time

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if is_knocked_back:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
		velocity = knockback_velocity
		move_and_slide()
		return
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_dir * SPEED
	move_and_slide()
	
	
	

func take_damge(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	if recovery_time.time_left == 0:
		var adjusted_force = knockback_force * (1.0 - knockback_resistance)
		knockback_velocity = knockback_direction * knockback_resistance * knockback_force
		is_knocked_back = true
		
		if knockback_duration > 0:
			await get_tree().create_timer(knockback_duration).timeout
			is_knocked_back = false
			velocity = Vector2.ZERO
		recovery_time.start(recovery_time_time)
		health -= damage
		print(damage, health)
		if health <= 0:
			health_depleted.emit()


func _on_hurtbox_take_damage(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	take_damge(damage, knockback_direction, knockback_force)


func _on_hurtbox_ground_take_damage(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	take_damge(damage, knockback_direction, knockback_force)
