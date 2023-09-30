extends CharacterBody2D

@export var turn_speed : float = .01
var speed = 0
var turn_amount = 0;
@export var ship_speed : int = 1
var health = 100

var starting_position

signal main_next_level
signal update_speed_ui(uispeed)
signal update_turn_ui(uiturn)
signal update_health(uihealth)
signal player_dead

func _ready():
	velocity = Vector2.ZERO
	starting_position = position

func _physics_process(delta):
	speed = clamp(speed, -20, 20)
	turn_amount = clamp(turn_amount, -1, 1)
	
	if Input.is_action_pressed("turn_left"):
		turn_amount -= turn_speed
		update_turn_ui.emit(turn_amount)
	elif Input.is_action_pressed("turn_right"):
		turn_amount += turn_speed
		update_turn_ui.emit(turn_amount)
	
	if Input.is_action_pressed("move_foward"):
		speed += ship_speed
		update_speed_ui.emit(speed)
	elif Input.is_action_pressed("move_backward"):
		speed -= ship_speed
		update_speed_ui.emit(speed)
	
	if(speed != 0):	
		rotation_degrees += turn_amount
		if speed <= 0:
			$Node/Ripples.visible = false
		elif speed < 10 and speed > 0:
			$Node.rotation_degrees = -turn_amount * 100
			$Node/Ripples/AnimatedSprite2D.play("small")
			$Node/Ripples.visible = true
		elif speed > 10:
			$Node.rotation_degrees = -turn_amount * 100
			$Node/Ripples/AnimatedSprite2D.play("big")
			$Node/Ripples.visible = true
			
	velocity = Vector2(0, -1).rotated(rotation) * speed
	#velocity = velocity.normalized()
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("COLLISION: ", collision.get_collider().name)
		health -= 1
		update_health.emit(health)
		
		if health < 0:
			player_dead.emit()

func next_level():
	position = starting_position
	speed = 0
	rotation_degrees = 0
	main_next_level.emit()
