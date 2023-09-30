extends Node

var level_1 = preload("res://levels/level_1.tscn")
var level_2 = preload("res://levels/level_2.tscn")
var level_3 = preload("res://levels/level_3.tscn")
var level_4 = preload("res://levels/level_4.tscn")
var level_5 = preload("res://levels/level_5.tscn")
var level_6 = preload("res://levels/level_6.tscn")

var levels = [level_1, level_2, level_3, level_4, level_5, level_6]
var current_level = 0;

var player_dead = false

func _process(delta):
	if Input.is_action_just_pressed("restart") and player_dead:
		get_tree().reload_current_scene()

func next_level():
	if current_level < 5 : 
		current_level += 1
		var new_level = levels[current_level].instantiate()
		$LevelHolder.get_child(0).queue_free()
		$LevelHolder.add_child(new_level)


func _on_ship_main_next_level():
	next_level()


func _on_ship_player_dead():
	player_dead = true
	$UI.player_dead()
	
