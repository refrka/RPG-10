class_name World extends Node2D



signal entity_added(entity: Entity)

signal entity_removed(entity: Entity)


@export var systems_root: Node

@export var entities_root: Node2D

var entities: Array[Entity]

var entity_registry: Dictionary[int, Entity]






func _ready() -> void:

	Game.world = self

	Scenes.world = self




func initialize() -> void:

	_initialize_authored_entities()

	for system in systems_root.get_children():

		system._world = self

		system._initialize()





func add_entity(entity: Entity, add_to_tree:= true) -> void:

	_register_entity(entity)

	if add_to_tree:

		entity._world = self

		entities_root.add_child(entity)

	entity._initialize()

	entity_added.emit(entity)




func remove_entity(entity: Entity) -> void:

	if not entities.is_empty():

		var last = entities.back()

		if last == entity:

			entities.pop_back()

		else:

			entities[entity._entities_index] = last

			last._entities_index = entity._entities_index

			entities.pop_back()

	entity_registry.erase(entity.id)

	if entity.is_inside_tree():

		entity.queue_free()

	else:

		entity.free()

	entity_removed.emit(entity)






func get_entities(

	with_components: Array[Script] = [],

	any_components: Array[Script] = [],

	exclude_components: Array[Script] = [],

	_source_entities: Array[Entity] = []

	) -> Array[Entity]:

	var _entities = _source_entities if not _source_entities.is_empty() else entities

	if with_components.is_empty() and any_components.is_empty() and exclude_components.is_empty():

		return _entities

	if not with_components.is_empty():

		_entities = _entities.filter(func(e): return e.has_components(with_components))

	if not any_components.is_empty():

		_entities = _entities.filter(func(e): return e.has_any_component(any_components))

	if not exclude_components.is_empty():

		_entities = _entities.filter(func(e): return not e.has_any_component(exclude_components))

	return _entities




func _register_entity(entity: Entity) -> void:

	entity_registry[entity.id] = entity

	entity._entities_index = entities.size()

	entities.append(entity)





func _initialize_authored_entities() -> void:

	for entity in entities_root.get_children():

		if entity.authored_id == -1:

			entity.generate_authored_id()

		entity.id = entity.authored_id

		_register_entity(entity)





func _generate_id(entity: Entity) -> void:

	var id = randi()

	while _is_id_taken(id):

		id = randi()

	entity.id = id



func _is_id_taken(id: int) -> bool:

	return entity_registry.has(id)







func process(delta: float) -> void:

	for system in systems_root.get_children():

		system.process(delta)



func physics_process(delta: float) -> void:

	for system in systems_root.get_children():

		system.physics_process(delta)