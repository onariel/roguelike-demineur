extends CharacterBody2D

signal health_depleted()

const SPEED = 80.0
const KNOCKBACK_FRICTION: float = 100
var max_health: float = 10
var health;
var knockback : float = 50.0
var recovery_time_time : float = 0.5
var attack_speed : float = 0.8
var bullet_speed : float = 50
var bullet_size : float = 5

var last_knockback_direction: Vector2
var last_knockback_force: float
var is_knocked_back: bool = false
var knockback_duration: float = 0.5
var knockback_velocity := Vector2.ZERO
var knockback_resistance: float = 1

@onready var hurtbox: hurtbox = $hurtbox
@onready var hurtbox_ground: hurtbox = $hurtbox_ground
@onready var recovery_time: Timer = $Recovery_time
@onready var main = get_tree().get_root().get_node("main area")
@onready var fire_ball = load("res://scene/characters/player/fire_ball.tscn")

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if is_knocked_back:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
		velocity = input_dir * SPEED/2 + knockback_velocity
	else:
		velocity = input_dir * SPEED
	
	move_and_slide()
	
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Click"):
		attack(get_global_mouse_position())

func take_damge(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	if recovery_time.time_left == 0:
		var adjusted_force = knockback_force * (1.0 - knockback_resistance)
		knockback_velocity = (knockback_direction * knockback_resistance) * knockback_force
		is_knocked_back = true
		
		if knockback_duration > 0:
			await get_tree().create_timer(knockback_duration).timeout
			is_knocked_back = false
			velocity = Vector2.ZERO
		recovery_time.start(recovery_time_time)
		health -= damage
		if health <= 0:
			health_depleted.emit()


func _on_hurtbox_take_damage(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	take_damge(damage, knockback_direction, knockback_force)


func _on_hurtbox_ground_take_damage(damage: float, knockback_direction : Vector2, knockback_force : float) -> void:
	take_damge(damage, knockback_direction, knockback_force)


func attack(target : Vector2) -> void:
	var instance = fire_ball.instantiate()
	instance.Direction = (global_position - target).angle()
	instance.Speed = bullet_speed
	instance.Spawn_Position = global_position
	instance.Spawn_Rotation = global_rotation
	instance.ball_rotation = (target - global_position).angle()
	instance.set_size(bullet_size)
	main.add_child.call_deferred(instance)
	
