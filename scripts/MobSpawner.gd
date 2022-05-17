extends Node

export (PackedScene) var mob_scene


func _ready():
	randomize()
	
	$UI/Retry.hide()


func _on_SpawnTimer_timeout():
	var mob = mob_scene.instance()
	var spawn_location = get_node("SpawnPath/SpawnLocation")
	spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	mob.initialize(spawn_location.translation, player_position)

	add_child(mob)
	
	mob.connect("squashed", $UI/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit():
	$MobTimer.stop()
	$UI/Retry.show()
	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UI/Retry.visible:
		# warning-ignore:return_value_discarded
		restart_current_scene()
		



func restart_current_scene():
	get_tree().reload_current_scene()
