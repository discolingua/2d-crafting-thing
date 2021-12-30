extends Node2D

export(int) var invWood : int = 0 setget set_invWood
export(int) var invStone : int = 0 setget set_invStone

func set_invWood(value:int):
	if value != invWood:
		invWood = int(clamp(value,0,999))
		$HUD_GUI/CountWood.text = str(invWood)

func set_invStone(value:int):
	if value != invStone:
		invStone = int(clamp(value,0,999))
