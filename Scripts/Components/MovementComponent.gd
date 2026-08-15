extends Node
class_name MovementComponent

## Скорость движения юнита
@export var speed: float = 200.0

## Целевая позиция
var target_position: Vector3
var is_moving: bool = false
var parent_unit: Node3D

func _ready():
	# Получаем родителя (юнита), к которому прикреплен компонент
	parent_unit = get_parent()

func _physics_process(delta: float) -> void:
	if not is_moving or parent_unit == null:
		return

	# Направление к цели
	var direction = (target_position - parent_unit.global_position).normalized()
	var distance = parent_unit.global_position.distance_to(target_position)

	# Если дошли (расстояние меньше 0.5)
	if distance < 0.5:
		is_moving = false
		parent_unit.global_position = target_position
		# Сообщаем родителю, что движение закончено (если есть такой сигнал)
		if parent_unit.has_method("on_movement_finished"):
			parent_unit.on_movement_finished()
		return

	# Движение
	parent_unit.global_position += direction * speed * delta

func set_target(pos: Vector3) -> void:
	target_position = pos
	is_moving = true
