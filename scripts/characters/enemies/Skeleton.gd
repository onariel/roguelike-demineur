extends enemies


const SPEED = 20.0

@onready var collision_hitbox: hitbox = $collision_hitbox


func _ready() -> void:
	super._ready()
	collision_hitbox.set_damage(self.damage)
	collision_hitbox.set_knockback(self.knockback)
	


func _physics_process(delta: float) -> void:
	
	var angle_to_go = player.global_position - global_position
	
	velocity = angle_to_go.normalized() * SPEED
	if is_knocked_back:
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, KNOCKBACK_FRICTION * delta)
		velocity = knockback_velocity + angle_to_go.normalized() * SPEED
	move_and_slide()



func _on_health_depleted() -> void:
	queue_free()
