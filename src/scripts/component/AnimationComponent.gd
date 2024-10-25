extends AnimatedSprite2D

var facing: face = face.RIGHT
var warping: bool = false
enum face{
	LEFT,
	RIGHT
}

func handle_animation(isOnFloor):
	if not warping:
		if Input.is_action_pressed("sprint"):
			speed_scale = 2
		else:
			speed_scale = 1
		if Input.is_action_pressed("left"):
			facing = face.LEFT

		if Input.is_action_pressed("right"):
			facing = face.RIGHT

		if facing == face.LEFT:
			if isOnFloor:
				if Input.is_action_pressed("left"):
					play("move_left")
				else: 
					play("idle_left")
			else:
				play("jump_left")

		if facing == face.RIGHT:
			if isOnFloor:
				if Input.is_action_pressed("right"):
					play("move_right")
				else:
					play("idle_right")
			else:
				play("jump_right")

func warp():
	warping = true
	play("warp")
