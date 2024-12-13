extends Node
class_name NPCStats

@export var maxhealth := 1 #The maximum health for this creature
@export var health := 1 #The base starting health for this creature
@export var invicibility := false #We will track if the mob is allowed to be hit
@export var afflicted := false #We will track if the mob is afflicted with any status affect
