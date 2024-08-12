# Fantastic State Machine Godot FSM
 Compartimentalizing the FSM

Features of the FSM
	Player
		Idle: Animation, listens for walk and attack signals
		Walk: Animation, move&slide + orientation,  listens for sprint, attack
		Sprint: Animation, faster move&side, listens for sprint release, attack
		Attack: Animation, waits for attack to finish
	Chicken! (Passive NPCs)
		Idle: Animation, occasially wanders
		Wander: Animation, Aimlessly move to a new location
Work in Progress
	Chicken!
		Flee
Planned
	Hostile NPCs
	Hit and Hurt boxes for all characters
	Health
	Death
