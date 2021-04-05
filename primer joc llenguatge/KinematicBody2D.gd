extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	$AnimatedSprite.play('default')
	if dead==true:
		queue_free()

func _on_hitbox_area_entered(area):
	if area.is_in_group('sword'):
		queue_free()
	
func _on_hitbox_body_entered(body):
	if body.has_method('_physics_process'):
		body.dead = true
	if body.has_method('_process'):
		dead = true
