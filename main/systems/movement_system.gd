class_name MovementSystem extends System





func _get_entities() -> Array[Entity]:

	var entities = _world.get_entities([VelocityComponent, HeightComponent])

	return entities




func process(_delta: float) -> void:

	for entity in _entities_cache:

		var velocity_component = entity.get_component(VelocityComponent)

		if velocity_component:

			entity.velocity = velocity_component.velocity

			entity.move_and_slide()