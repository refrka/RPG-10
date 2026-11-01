extends Node


signal game_state_changed(new_state: GameState)


enum GameState {

	MAIN_MENU,

	GAME,

}


const SAVE_PATH = "user://save.json"


var game_state: GameState

var world: World

var save_data: SaveData




func _ready() -> void:

	load_save_data()

	set_game_state(GameState.MAIN_MENU)



func start() -> void:

	set_game_state(GameState.GAME)

	if not save_data:

		save_data = SaveData.new()

		save()

	world.initialize()



func exit() -> void:

	pass



func quit() -> void:

	get_tree().quit()



func reset() -> void:

	save_data = SaveData.new()

	DirAccess.remove_absolute(SAVE_PATH)



func save() -> void:

	var save_dict = save_data.to_dict()

	_write_dict_to_file(save_dict, SAVE_PATH)




func load_save_data() -> void:

	var save_dict = _get_dict_from_file(SAVE_PATH)

	if save_dict.is_empty():

		return

	save_data = SaveData.load_dict(save_dict)	






func set_game_state(_game_state: GameState) -> void:

	game_state = _game_state

	game_state_changed.emit(game_state)







func _write_dict_to_file(dict: Dictionary, file_path: String) -> void:

	var file = FileAccess.open(file_path, FileAccess.WRITE)

	file.store_string(JSON.stringify(dict, " "))

	file.close()




func _get_dict_from_file(file_path: String) -> Dictionary:

	if !FileAccess.file_exists(file_path):

		return {}

	var file = FileAccess.open(file_path, FileAccess.READ)

	var json = JSON.new()

	json.parse(file.get_as_text())

	file.close()

	return json.data











func _process(delta: float) -> void:

	if game_state == GameState.GAME:

		world.process(delta)



func _physics_process(delta: float) -> void:

	if game_state == GameState.GAME:

		world.physics_process(delta)