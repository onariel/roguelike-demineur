extends CharacterBody2D

@export var damage : float

@onready var hitbox: hitbox = $hitbox

func _ready() -> void:
	hitbox.set_damage(damage)
