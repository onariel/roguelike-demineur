extends CharacterBody2D

signal health_depleted()

const SPEED = 80.0
const JUMP_VELOCITY = -400.0
var health;
var knockback = 50.0
var recovery_time_time = 0.5
var last_hit_verctor: Vector2
@export var max_health: float

@onready var hurtbox: hurtbox = $hurtbox
@onready var hurtbox_ground: hurtbox = $hurtbox_ground
@onready var recovery_time: Timer = $Recovery_time

func _ready() -> void:
	health = max_health

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	
	if recovery_time.time_left < 0.25:
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)
	else:
		var angle = get_angle_to(last_hit_verctor)
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
	move_and_slide()

func take_damge(damage: float, pos : Vector2) -> void:
	if recovery_time.time_left == 0:
		last_hit_verctor = pos
		print(get_angle_to(pos))
		recovery_time.start(recovery_time_time)
		health -= damage
		print(damage, health)
		if health <= 0:
			health_depleted.emit()


func _on_hurtbox_take_damage(damage: float, pos : Vector2) -> void:
	take_damge(damage, pos)


func _on_hurtbox_ground_take_damage(damage: float, pos : Vector2) -> void:
	take_damge(damage, pos)
