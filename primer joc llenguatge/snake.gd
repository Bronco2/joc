extends KinematicBody2D


const SPEED = 50
const GRAVITY = 17

const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
var pan
var on_ground = false
var jumpcount = 1
var num = 0
var att = false
var att2 = false
var dir = 1

func _ready():
	pass 


func _physics_process(_delta):
	
	velocity.x = SPEED * dir
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
		jumpcount = 1
	else:
		on_ground = false
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	if is_on_wall():
		dir = dir * -1
#		$RayCast2D.position.x *= -1

	if $RayCast2D.is_colliding() == false:
		dir = dir * -1
#		$RayCast2D.position.x *= -1
	scale.x *= dir
	
	velocity = move_and_slide(velocity, FLOOR)
	anima(velocity)
	
#	if is_on_wall():
#		dir = dir * -1
#		$RayCast2D.position.x *= -1
#
#	if $RayCast2D.is_colliding() == false:
#		dir = dir * -1
#		$RayCast2D.position.x *= -1

	
func anima(velocity):
	$AnimatedSprite.play("run")

