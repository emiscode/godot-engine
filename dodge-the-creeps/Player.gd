extends Area2D

signal hit

export var speed = 400

var screen_size
var distance = 1
var move_up = "ui_up"
var move_left = "ui_left"
var move_down = "ui_down"
var move_right = "ui_right"
var velocity = Vector2.ZERO

func _ready():
	$AnimatedSprite.play()
	$AnimatedSprite2.play()
	$AnimatedSprite3.play()
	$AnimatedSprite4.play()
	$AnimatedSprite6.play()
	screen_size = get_viewport_rect().size

func _process(delta):
	check_action_pressed()
	run_animated_sprite()
	update_position(delta)
	update_animation()
	
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func check_action_pressed():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed(move_right):
		velocity.x += distance
	if Input.is_action_pressed(move_left):
		velocity.x -= distance
	if Input.is_action_pressed(move_down):
		velocity.y += distance
	if Input.is_action_pressed(move_up):
		velocity.y -= distance
	
func run_animated_sprite():
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	# else:
		# $AnimatedSprite.stop()
	
func update_position(delta):
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func update_animation():
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		# $AnimatedSprite.flip_v = velocity.y > 0
