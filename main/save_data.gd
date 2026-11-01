class_name SaveData extends Resource



var game_data:= {



}

var player_data:= {



}

var world_data:= {



}





func to_dict() -> Dictionary:

	return {

		"game_data": game_data,

		"player_data": player_data,

		"world_data": world_data,

	}




static func load_dict(dict: Dictionary) -> SaveData:

	var data = SaveData.new()

	data.game_data = dict.game_data

	data.player_data = dict.player_data

	data.world_data = dict.world_data

	return data