extends KinematicBody2D

var speed = 80.0
var velocity = Vector2.ZERO
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	#pressed
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	#released
	if Input.is_action_just_released("ui_left"):
		direction.x = 0
	if Input.is_action_just_released("ui_right"):
		direction.x = 0
	if Input.is_action_just_released("ui_up"):
		direction.y = 0
	if Input.is_action_just_released("ui_down"):
		direction.y = 0
	
	
	
	playAnimationPlayer(direction)
	velocity.x = direction.x * speed 
	velocity.y = direction.y * speed
	
	velocity = move_and_slide(velocity)
	





func playAnimationPlayer(direct_player: Vector2) -> void:
	
	if direct_player == Vector2.ZERO:
		$PlayerAnimated.play("idle")
	elif direct_player != Vector2.ZERO and direct_player.x < 0: 	
		$PlayerAnimated.flip_h = true
		$PlayerAnimated.play("walk")
	else: 
		$PlayerAnimated.play("walk")
		$PlayerAnimated.flip_h = false






func _on_TouchLeft_pressed() -> void:
	direction.x -= 1
	


func _on_TouchRight_pressed() -> void:
	direction.x += 1


func _on_TouchDown_pressed() -> void:
	direction.y += 1


func _on_TouchUp_pressed() -> void:
	direction.y -= 1


func _on_TouchLeft_released() -> void:
	direction.x = 0


func _on_TouchRight_released() -> void:
	direction.x = 0


func _on_TouchDown_released() -> void:
	direction.y = 0


func _on_TouchUp_released() -> void:
	direction.y = 0
