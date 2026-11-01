class_name PlayerInputSystem extends System


var _player: Entity

var _velocity_component: VelocityComponent



var input_dir: Vector2



func _initialize() -> void:

	super()

	if not _entities_cache.is_empty():

		_player = _entities_cache[0]

		_velocity_component = _player.get_component(VelocityComponent)



func _get_entities() -> Array[Entity]:

	return _world.get_entities([PlayerInputComponent])




func process(_delta: float) -> void:

	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	_velocity_component.velocity = input_dir * 100.0
