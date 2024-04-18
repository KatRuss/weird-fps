extends Resource
class_name PlayerData

@export var base_speed: float
@export var interact_speed: float
@export var jump_velocity: float


# Camera Variables
@export var mouse_sensitivity: float
@export var interact_ms_mod: float
@export var bob_freq: float
@export var bob_amp: float

# Non-Modifiable public variables
var t_bob: float = 0.0
var is_interacting = false
var looking_at: InteractComponent
