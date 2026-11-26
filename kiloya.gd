
extends CharacterBody2D

# KILOYA MOVEMENT
const SPEED = 250.0
const JUMP_FORCE = -450.0

var facing = 1
var beam_ready = true

func _physics_process(delta):

    # Gravity
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Left and Right
    var direction = Input.get_axis("ui_left", "ui_right")
    velocity.x = direction * SPEED

    if direction != 0:
        facing = sign(direction)

    # Jump
    if Input.is_action_just_pressed("ui_accept"):
        if is_on_floor():
            velocity.y = JUMP_FORCE

    # Three Abilities
    if Input.is_action_just_pressed("beam"):
        radiation_blast()

    if Input.is_action_just_pressed("kick"):
        danger_kick()

    if Input.is_action_just_pressed("punch"):
        power_punch()

    move_and_slide()


# ABILITY 1: RADIATION BLAST
func radiation_blast():

    if not beam_ready:
        return

    beam_ready = false

    print("KILOYA RADIATION BLAST!")
    print("ENERGY WAVE ACTIVATED!")

    for enemy in get_tree().get_nodes_in_group("enemies"):
        if global_position.distance_to(enemy.global_position) < 350:
            if enemy.has_method("take_hit"):
                enemy.take_hit(40)

    await get_tree().create_timer(5.0).timeout
    beam_ready = true


# ABILITY 2: DANGER KICK
func danger_kick():

    print("DANGER KICK ACTIVATED!")

    for enemy in get_tree().get_nodes_in_group("enemies"):
        if global_position.distance_to(enemy.global_position) < 100:
            if enemy.has_method("take_hit"):
                enemy.take_hit(30)


# ABILITY 3: POWER PUNCH
func power_punch():

    print("POWER PUNCH ACTIVATED!")

    for enemy in get_tree().get_nodes_in_group("enemies"):
        if global_position.distance_to(enemy.global_position) < 70:
            if enemy.has_method("take_hit"):
                enemy.take_hit(15)
