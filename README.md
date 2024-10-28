# Fantastic State Machine Godot FSM
 Compartimentalizing the FSM

Features of the FSM
---
	Hit and Hurt boxes for all characters
 
	Player
		Idle: Animation, listens for walk and attack signals
		Walk: Animation, move&slide + orientation,  listens for sprint, attack
		Sprint: Animation, faster move&side, listens for sprint release, attack
		Attack: Animation, waits for attack to finish, creates a hurtbox
	Chicken! (Passive NPCs)
		Idle: Animation, occasially wanders			
		Wander: Animation, Aimlessly move to a new location
		Flee: Animation, locates damage source and moves away from it
Work in Progress
---
	Chicken!
		Health / Death
Planned
---
	Hostile NPCs
	NPC Hunger
 	NPC Personalities
	NPC Population Control
