extends KinematicBody2D


const SPEED = 200
const GRAVITY = 17
const JUMP_POWER = -320
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
var pan
var on_ground = false
var jumpcount = 1
var num = 0
var att = false
var dead = false

func _ready():
	pass 


func _physics_process(_delta):
	if dead == false:
		if Input.is_action_just_pressed("ui_accept"):
			att = true
			$Sword/aaa.disabled = false
		if att == false:
			$Sword/aaa.disabled = true
		
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
	#		if on_ground:
	#			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			
	#		if on_ground:
	#			$AnimatedSprite.play("run")
			$AnimatedSprite.flip_h = true
		else:
			velocity.x = 0
	#		if on_ground:
	#			$AnimatedSprite.play("iddle")
			
		if Input.is_action_just_pressed("ui_up"):
			if (on_ground):
				velocity.y = JUMP_POWER
				jumpcount -= 1
				on_ground = false
			else:
				if jumpcount > 0 and Input.is_action_just_pressed("ui_up") and (velocity.y > 1 or not velocity.x == 0):
					velocity.y = JUMP_POWER
					jumpcount -= 1
					
		
		
		velocity.y += GRAVITY
		if is_on_floor():
			on_ground = true
			jumpcount = 1
		else:
			on_ground = false
			
		velocity = move_and_slide(velocity, FLOOR)
	anima(velocity)
	
	
	
func anima(velocity):
	if dead:
		$AnimatedSprite.play("death")
	else:
		if on_ground:
			if att:
				$AnimatedSprite.play("att")
			else:
				if velocity.length() < 0.5:
					$AnimatedSprite.play("iddle")
				else:
					$AnimatedSprite.play("run")
		else:
			if velocity.y <0:
				$AnimatedSprite.play("jump")
			else:
				$AnimatedSprite.play("fall")
			
	


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		dead = false
		
	if $AnimatedSprite.animation == "att":
		att = false
		$Sword/aaa.disabled = true
		
