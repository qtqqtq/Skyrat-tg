/**
 * # Sound Emitter Component
 *
 * A component that emits a sound when it receives an input.
 */
/obj/item/circuit_component/soundemitter
	display_name = "Sound Emitter"
	desc = "A component that emits a sound when it receives an input. The frequency is a multiplier which determines the speed at which the sound is played"
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL

	/// Sound to play
	var/datum/port/input/option/sound_file

	/// Volume of the sound when played
	var/datum/port/input/volume

	/// Frequency of the sound when played
	var/datum/port/input/frequency

	/// The cooldown for this component of how often it can play sounds.
	var/sound_cooldown = 2 SECONDS

	var/list/options_map

/obj/item/circuit_component/soundemitter/get_ui_notices()
	. = ..()
	. += create_ui_notice("Sound Cooldown: [DisplayTimeText(sound_cooldown)]", "orange", "stopwatch")


/obj/item/circuit_component/soundemitter/Initialize()
	. = ..()
	volume = add_input_port("Volume", PORT_TYPE_NUMBER, default = 35)
	frequency = add_input_port("Frequency", PORT_TYPE_NUMBER, default = 0)

/obj/item/circuit_component/soundemitter/populate_options()
	var/static/component_options = list(
		"Buzz" = 'sound/machines/buzz-sigh.ogg',
		"Buzz Twice" = 'sound/machines/buzz-two.ogg',
		"Chime" = 'sound/machines/chime.ogg',
		"Honk" = 'sound/items/bikehorn.ogg',
		"Ping" = 'sound/machines/ping.ogg',
		"Sad Trombone" = 'sound/misc/sadtrombone.ogg',
		"Warn" = 'sound/machines/warning-buzzer.ogg',
		"Slow Clap" = 'sound/machines/slowclap.ogg',
	)
	sound_file = add_option_port("Sound Option", component_options)
	options_map = component_options


/obj/item/circuit_component/soundemitter/input_received(datum/port/input/port)
	. = ..()
	volume.set_input(clamp(volume.input_value, 0, 100), FALSE)
	frequency.set_input(clamp(frequency.input_value, -100, 100), FALSE)
	if(.)
		return

	if(TIMER_COOLDOWN_CHECK(parent, COOLDOWN_CIRCUIT_SOUNDEMITTER))
		return

	var/sound_to_play = options_map[sound_file.input_value]
	if(!sound_to_play)
		return

	playsound(src, sound_to_play, volume.input_value, frequency != 0, frequency = frequency.input_value)

	TIMER_COOLDOWN_START(parent, COOLDOWN_CIRCUIT_SOUNDEMITTER, sound_cooldown)
