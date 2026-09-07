extends CharacterBody2D


var Speed : float
var Direction : float
var Spawn_Position : Vector2
var Spawn_Rotation : float
var zindex : int 
var ball_rotation : float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func initialisation(damage: float, new_size: float, knockback: float) -> void:
	var hitbox_firebal = self.get_node("hitbox")
	var animation_player = self.get_node("AnimationPlayer")
	hitbox_firebal.set_damage(damage)
	hitbox_firebal.set_knockback(knockback)
	scale = Vector2(new_size, new_size)
	animation_player.play("spawn")
	
func _ready() -> void:
	global_position = Spawn_Position
	global_rotation = Spawn_Rotation
	animated_sprite_2d.play("growing")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if false:
		print(delta)
	rotation = ball_rotation
	if !animated_sprite_2d.is_playing():
		animated_sprite_2d.play("crusing")
	velocity = Vector2(0, -Speed).rotated(Direction).rotated(-PI/2)
	move_and_slide()

func _on_collision_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if false:
		print(body_rid, body, body_shape_index, local_shape_index)
	queue_free()
	return
