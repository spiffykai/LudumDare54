extends Control

func update_speed_bar(speed):
	$SpeedBar.value = speed

func update_turn_bar(turn):
	$TurnBar.value = turn

func _on_ship_update_speed_ui(uispeed):
	update_speed_bar(uispeed)

func _on_ship_update_turn_ui(uiturn):
	update_turn_bar(uiturn)

func _on_ship_update_health(uihealth):
	$DamageBar.value = uihealth

func player_dead():
	$DeadLabel.visible = true
