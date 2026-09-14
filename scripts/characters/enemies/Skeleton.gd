extends enemies


const SPEED = 20.0
var attacking: bool = false
var target_in_range: bool = false


@onready var collision_hitbox: hitbox = $collision_hitbox
@onready var attack_hitbox: hitbox = $attack_hitbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	super._ready()
	collision_hitbox.set_damage(self.damage)
	collision_hitbox.set_knockback(self.knockback)
	attack_hitbox.set_damage(self.damage)
	attack_hitbox.set_knockback(self.knockback)
	attack_hitbox.monitorable = false
	attack_hitbox.scale = Vector2(0,0)


func _physics_process(delta: float) -> void:
	
	var angle_to_go = player.global_position - global_position
	if !attacking:
		velocity = angle_to_go.normalized() * SPEED
		if is_knocked_back:
			knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
			velocity = knockback_velocity + angle_to_go.normalized() * SPEED
	else:
		velocity = Vector2(0,0)
		if is_knocked_back:
			knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
			velocity = knockback_velocity
	move_and_slide()

func _process (delta: float) -> void:
	if false:
		print(delta)
	if attacking:
		if animated_sprite_2d.frame == 6 or animated_sprite_2d.frame == 7:
			attack_hitbox.monitorable = true
			attack_hitbox.scale = Vector2(1,1)
		else:
			attack_hitbox.monitorable = false
			attack_hitbox.scale = Vector2(0,0)
	if !animated_sprite_2d.is_playing():
		if attacking:
			animated_sprite_2d.play("attack")
		else:
			animated_sprite_2d.play("walk")

func _on_health_depleted() -> void:
	queue_free()

func _on_attack_zone_area_entered(area: Area2D) -> void:
	if area is hurtbox:
		target_in_range = true
		if !attacking:
			attacking = true
			animated_sprite_2d.play("attack")

func _on_attack_zone_area_exited(area: Area2D) -> void:
	if area is hurtbox:
		target_in_range = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if !target_in_range:
		attacking = false
