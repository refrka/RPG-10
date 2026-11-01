class_name CollisionSystem extends System






func _initialize() -> void:

	super()



func _get_entities() -> Array[Entity]:

	return _world.get_entities([], [BodyComponent])





func physics_process(_delta: float) -> void:

	for entity in _entities_cache:

		var velocity_component = entity.get_component(VelocityComponent)

		if velocity_component:
		
			var collision_count = entity.get_slide_collision_count()

			