extends KinematicBody2D
var rng = RandomNumberGenerator.new()
var speedRandom = 37
export (int) var speed = 450
export (int) var jump_speed = -1250
export (int) var gravity = 4000

const TYPE = "player"
var powerup = 0
var is_dead = false
var velocity = Vector2.ZERO
var error = preload("res://error.tscn")
func _ready():
	rng.randomize()
	speedRandom = rng.randi_range(0,50)
	InputMap.add_action("walk_left")
	var ev = InputEventKey.new()
	ev.scancode = KEY_LEFT
	InputMap.action_add_event("walk_left", ev)
	InputMap.add_action("walk_right")
	var ev2 = InputEventKey.new()
	ev2.scancode = KEY_RIGHT
	InputMap.action_add_event("walk_right", ev2)
	InputMap.add_action("jump")
	var ev3 = InputEventKey.new()
	ev3.scancode = KEY_UP
	InputMap.action_add_event("jump", ev3)
	if speedRandom == 37:
		speed = -450
	else:
		speed = 450
		
	
func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		rng.randomize()
		speedRandom = rng.randi_range(0,100)
		dir += 1
		if speedRandom == 100:
			$anim.play("glitch")

			
	if Input.is_action_pressed("walk_left"):
		rng.randomize()
		speedRandom = rng.randi_range(0,100)
		dir -= 1
		if speedRandom == 100:
			$anim.play("glitch")
		rng.randomize()
		speedRandom = rng.randi_range(0,250)
		if speedRandom == 250:
			if get_tree().get_root().is_window_fullscreen() == true:
				get_tree().get_root().set_window_fullscreen(false)
			else:
				get_tree().get_root().set_window_fullscreen(true)
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		rng.randomize()
		speedRandom = rng.randi_range(0,10)
		if is_on_floor() or speedRandom == 10:
			velocity.y = jump_speed
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$anim.play("death")
	$Timer.start()

func boss_dead(lev):
	velocity = Vector2(0,0)
	$anim.play("boss_dead")
	$BossLev.start()
	get_tree().change_scene(lev)

func _on_JumpBoost_powerup_collected():
	powerup = 1
	Global.powerup = 1


func _on_Timer_timeout():
	get_tree().change_scene("res://error.tscn")

func finish():
	$anim.play("finish")
	#$FinishTimer.start()
	
func _on_FinishTimer_timeout():
	print("next level")
	



func _on_BossLev_timeout():
	get_tree().change_scene("res://Scenes/Level_6")
