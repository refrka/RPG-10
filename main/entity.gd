@tool 
class_name Entity extends Node2D




@export var authored_id: int

@export var components: Array[Component]



var id: int

var _world: World

var _entities_index: int




func _enter_tree() -> void:

	if Engine.is_editor_hint():

		generate_authored_id()




func _initialize() -> void:

	pass




func get_component(component_script: Script) -> Component:

	for component in components:

		if component.get_script() == component_script:

			return component

	return null




func has_component(component_script: Script) -> bool:

	return get_component(component_script) != null




func has_components(component_scripts: Array[Script]) -> bool:

	for component_script in component_scripts:

		if not has_component(component_script):

			return false

	return true




func has_any_component(component_scripts: Array[Script]) -> bool:

	for component_script in component_scripts:

		if has_component(component_script):

			return true
	
	return false





func generate_authored_id() -> void:

	var _authored_id = randi()

	while _is_authored_id_taken(_authored_id):

		_authored_id = randi()

	authored_id = _authored_id


	


func _is_authored_id_taken(_authored_id: int) -> bool:

	for child in get_parent().get_children():

		if child.authored_id == _authored_id:

			return true

	return false