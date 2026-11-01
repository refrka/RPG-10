extends Node



var main_menu: MainMenu

var world: World



func _ready() -> void:

	Game.game_state_changed.connect(_on_game_state_changed)




func _update_scene(game_state: Game.GameState) -> void:

	match game_state:

		Game.GameState.MAIN_MENU:

			main_menu.visible = true

			world.visible = false

		Game.GameState.GAME:

			world.visible = true

			main_menu.visible = false



func _on_game_state_changed(game_state: Game.GameState) -> void:

	_update_scene(game_state)