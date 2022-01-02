extends Node2D


# number of resources in inventory
export(int) var invWood : int = 0 setget set_invWood
export(int) var invStone : int = 0 setget set_invStone


func set_invWood(value:int):
	if value != invWood:
		invWood = int(clamp(value,0,999))
		$HUD_GUI/CountWood.text = str(invWood).pad_zeros(3)


func set_invStone(value:int):
	if value != invStone:
		invStone = int(clamp(value,0,999))
		$HUD_GUI/CountStone.text = str(invStone).pad_zeros(3)
		
