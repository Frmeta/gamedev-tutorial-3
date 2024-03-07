extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var GRAVITY = 1200
export (float) var delay_press_twice = 0.2

onready var audio_stream_player = $AudioStreamPlayer

const UP = Vector2(0,-1)
var velocity = Vector2()
var jump_count = 0

var delay_left = 0
var delay_right = 0

var is_on_floor_prev = false

func get_input():
	velocity.x = 0
	
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		# crouch
		$SpriteParent.scale.y = 0.9
		$SpriteParent/Sprite.play("crouch")
	else:
		$SpriteParent.scale.y = 1
		
		
		if is_on_floor():
			jump_count = 1
		
		# jump
		if Input.is_action_just_pressed("ui_up"):
			if is_on_floor():
				jump_count = 2
				
			if jump_count > 0:
				jump_count -= 1
				velocity.y = jump_speed
				audio_stream_player.play_jump()
			
	
		# dash
		if Input.is_action_just_pressed('ui_right'):
			delay_left = 0
			$SpriteParent/Sprite.flip_h = false
			if (delay_right > 0):
				delay_right = 0
				velocity.x += speed * 10
			else:
				delay_right = delay_press_twice
				
		if Input.is_action_just_pressed('ui_left'):
			delay_right = 0
			$SpriteParent/Sprite.flip_h = true
			if (delay_left > 0):
				delay_left = 0
				velocity.x -= speed * 10
			else:
				delay_left = delay_press_twice
				
		if Input.is_action_pressed('ui_right'):
			velocity.x += speed
			
		if Input.is_action_pressed('ui_left'):
			velocity.x -= speed
		
		
		if not is_on_floor():
			if velocity.y > 5:
				$SpriteParent/Sprite.play("fall")
			else:
				$SpriteParent/Sprite.play("jump")
		elif not is_on_floor_prev:
			audio_stream_player.play_land()
		elif velocity.x == 0:
			$SpriteParent/Sprite.play("idle")
		else:
			$SpriteParent/Sprite.play("walk")
			
		is_on_floor_prev = is_on_floor()
			
			
			

func _physics_process(delta):
	delay_left -= delta
	delay_right -= delta
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	
	if position.y > 1000:
		position = Vector2(500, 0)
		velocity.y = 0


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		audio_stream_player.play_explosion()
