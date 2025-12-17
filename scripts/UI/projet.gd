extends MarginContainer

@onready var lbl_name: Label = $MarginContainer/NinePatchRect/Button/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/lblName
@onready var lbl_status: Label = $MarginContainer/NinePatchRect/Button/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/lblStatus
@onready var progress_bar: ProgressBar = $MarginContainer/NinePatchRect/Button/MarginContainer/VBoxContainer/HBoxContainer2/ProgressBar
@onready var lbl_time_left: Label = $MarginContainer/NinePatchRect/Button/MarginContainer/VBoxContainer/HBoxContainer2/lblTimeLeft
@onready var timer: Timer = $Timer


var timeTotal : int
var timeLeft : int
var time : int

var project : Project

func _process(delta: float) -> void:
	lbl_time_left.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]	# pour afficher au format min:sec


func _ready() -> void:
	timer.start(time)	# temps en secondes
	progress_bar.max_value = time


func setStatus(statusValue : int) -> void:
	if statusValue == 0:
		lbl_status.text = "non commencé"
	elif statusValue == 1:
		lbl_status.text = "en cours"
	elif statusValue == 2:
		lbl_status.text = "en pause"
	elif statusValue >= 3:
		lbl_status.text = "fini"


func setProject(proj : Project) -> void:
	project = proj
	print(project)
	
	
func setTime(time : int) -> void:
	timeTotal = time
	progress_bar.max_value = timeTotal
	
	
func setTimeLeft(time : int) -> void:
	timeLeft = time


func setVisibility(vis : bool) -> void:
	visible = vis


func startProject() -> void:
	pass


func _on_button_pressed() -> void:
	UiController.emit_open_project_menu(project)
