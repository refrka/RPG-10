class_name System extends Node



@warning_ignore_start("unused_private_class_variable")

var _world: World

var _entities_cache: Array[Entity]





func _initialize() -> void:

	_entities_cache = _get_entities()

	




func _get_entities() -> Array[Entity]:

	return _entities_cache




func process(_delta: float) -> void:

	pass




func physics_process(_delta: float) -> void:

	pass