extends State
class_name PlayerAttack

@export var sprite : AnimatedSprite2D


func Enter():
	print("Entered the Attack Sate")
	sprite.play("Attack")
	sprite.connect("animation_finished", _on_animation_finished)

func Exit():
	if sprite.is_connected("animation_finished", _on_animation_finished):
		sprite.disconnect("animation_finished", _on_animation_finished)

func _on_animation_finished():
	Transition("Idle")

func Transition(newstate):
	state_transition.emit(self, newstate)
