extends CharacterBody2D

@export var damage : float
@export var knockback : float


@onready var hitbox: hitbox = $hitbox

func _ready() -> void:
	hitbox.set_damage(damage)
	hitbox.set_knockback(knockback)
