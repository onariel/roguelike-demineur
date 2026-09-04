extends CharacterBody2D


var Speed : float
var Direction : float
var Spawn_Position : Vector2
var Spawn_Rotation : float
var zindex : int 
var ball_rotation : float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func set_size(new_size: float) -> void:
	scale = Vector2(new_size, new_size)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Spawn_Position
	global_rotation = Spawn_Rotation
	animated_sprite_2d.play("growing")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	rotation = ball_rotation
	if !animated_sprite_2d.is_playing():
		animated_sprite_2d.play("crusing")
	velocity = Vector2(0, -Speed).rotated(Direction).rotated(-PI/2)
	move_and_slide()








func _on_collision_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	queue_free()
