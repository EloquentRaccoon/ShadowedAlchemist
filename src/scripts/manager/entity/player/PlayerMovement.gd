class_name PlayerMovement
extends Node2D

#----------------------
# Handle all movement
#----------------------
@export_category("Movement Parameters")
#Jump parameters
@export var Jump_Height: float = 96.0
@export var Jump_Distance: float = 256.0

@export var Acceleration: float = .2
@export var Friction: float = 12.0
#Timers
@export var Jump_Peak_Time: float = 0.5
@export var Jump_Fall_Time: float = 0.3
@export var Coyote_Time: float = .1
@export var Jump_Buffer_Time: float = .15

#Timers
@onready var coyote_timer = $Coyote_Timer
@onready var jump_buffer_timer = $Jump_Buffer_Timer

@onready var player = $".."
# Movement base values, will be overriden with calculations
var Speed: float = 300.0
var Sprint: float = 500.0
var Jump_Velocity: float = -400.0
var Jump_Available: bool = true
var Jump_Buffer: bool = false

# Gravity 
var Jump_Gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var Fall_Gravity: float = 980.1

var Can_Move: bool = true

func _ready():
	Calculate_Movement_Parameters()

# Calculate all the movement values
func Calculate_Movement_Parameters()-> void:
	
	Jump_Gravity = (-2 * Jump_Height)/pow(Jump_Peak_Time, 2)
	Fall_Gravity = (-2 * Jump_Height)/pow(Jump_Fall_Time, 2) 
	Jump_Velocity = Jump_Gravity * Jump_Peak_Time
	
	Speed = Jump_Distance/(Jump_Peak_Time+Jump_Fall_Time)
	Sprint = Speed * 1.3

# Process movement
func Move_Character(delta):
	#Handeling player jump
	if Input.is_action_just_pressed("jump"):
		if Jump_Available:
			Jump()
		else: 
			Jump_Buffer = true
			if jump_buffer_timer.is_stopped():
				jump_buffer_timer.start(Jump_Buffer_Time)
	
	#Handeling Coyote Jump
	if not player.is_on_floor():
		if Jump_Available:
			if coyote_timer.is_stopped():
				coyote_timer.start(Coyote_Time)
		if player.velocity.y < 0:
			player.velocity.y -= Jump_Gravity * delta
		else:
			player.velocity.y -= Fall_Gravity * delta

	else: 	
		Jump_Available = true
		coyote_timer.stop()
		if Jump_Buffer:
			Jump()
			Jump_Buffer = false

	#Handeling Horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		if Input.is_action_pressed("sprint"):
			player.velocity.x = move_toward(direction * Sprint, 0, Acceleration)
		else:
			player.velocity.x = move_toward(direction * Speed, 0, Acceleration) 
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, Friction)
		
	player.move_and_slide()

func Jump()->void:
	player.velocity.y = Jump_Velocity
	Jump_Available = false

func _on_coyote_timer_timeout() -> void:
	Jump_Available = false

func _on_jump_buffer_timer_timeout() -> void:
	Jump_Buffer = false
