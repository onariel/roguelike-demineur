extends CharacterBody2D

@export var damage : float
@export var knockback : float


@onready var hitbox_fireball: hitbox = $hitbox

func _ready() -> void:
	hitbox_fireball.set_damage(damage)
	hitbox_fireball.set_knockback(knockback)
