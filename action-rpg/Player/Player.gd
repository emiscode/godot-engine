extends KinematicBody2D

export var speed = 100
export var friction = 15
export var acceleration = 3

var velocity = Vector2()

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):	
	animatePlayer(get_input(), delta)

func get_input():
	var input = Vector2.ZERO
	var input_right = Input.get_action_strength("ui_right")
	var input_left = Input.get_action_strength("ui_left")
	var input_up = Input.get_action_strength("ui_up")
	var input_down = Input.get_action_strength("ui_down")
	
	input.x = input_right - input_left
	input.y = input_down - input_up
	
	return input.normalized()
	
func animatePlayer(input, delta):
	if input != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input)
		animationTree.set("parameters/Run/blend_position", input)
		animationState.travel("Run")
		velocity = lerp(velocity, input * speed, acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = lerp(velocity, Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide(velocity)
	
	
	
