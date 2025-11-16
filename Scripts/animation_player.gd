extends AnimationPlayer

func _ready():
	var anim:AnimationPlayer = self
	anim.play("StartAnimation")


func _on_animation_finished(anim_name):
	var anim:AnimationPlayer = self
	anim.play("Idle")
