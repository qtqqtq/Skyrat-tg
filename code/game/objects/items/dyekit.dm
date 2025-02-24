/obj/item/dyespray
	name = "hair dye spray"
	desc = "A spray to dye hair as well as giving it any gradient you'd like." // SKYRAT EDIT - Making the dyespray change hair color
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/dyespray.dmi'
	icon_state = "dyespray"

	var/uses = 40 //SKYRAT EDIT ADDITION

/obj/item/dyespray/attack_self(mob/user)
	dye(user, user)

/obj/item/dyespray/pre_attack(atom/target, mob/living/user, params)
	dye(target, user)
	return ..()

/**
 * Applies a gradient and a gradient color to a mob.
 *
 * Arguments:
 * * target - The mob who we will apply the gradient and gradient color to.
 */
/* SKYRAT EDIT REMOVAL - MOVED TO MODULAR (modular_skyrat\master_files\code\game\objects\items\dyekit.dm)
/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return

	if(!uses) //SKYRAT EDIT ADDITION
		return //SKYRAT EDIT ADDITION

	var/mob/living/carbon/human/human_target = target
	var/beard_or_hair = tgui_alert(user, "What do you want to dye?", "Character Preference", list("Hair", "Facial Hair"))
	if(!beard_or_hair || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
		return

	var/list/choices = beard_or_hair == "Hair" ? GLOB.hair_gradients_list : GLOB.facial_hair_gradients_list
	var/new_grad_style = tgui_input_list(user, "Choose a color pattern", "Character Preference", choices)
	if(isnull(new_grad_style))
		return
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
		return

	var/new_grad_color = input(user, "Choose a secondary hair color:", "Character Preference",human_target.grad_color) as color|null
	if(!new_grad_color || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE) || !user.CanReach(target))
		return

	to_chat(user, span_notice("You start applying the hair dye..."))
	if(!do_after(user, 3 SECONDS, target))
		return
	var/gradient_key = beard_or_hair == "Hair" ? GRADIENT_HAIR_KEY : GRADIENT_FACIAL_HAIR_KEY
	LAZYSETLEN(human_target.grad_style, GRADIENTS_LEN)
	LAZYSETLEN(human_target.grad_color, GRADIENTS_LEN)
	human_target.grad_style[gradient_key] = new_grad_style
	human_target.grad_color[gradient_key] = sanitize_hexcolor(new_grad_color)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 5)
	human_target.update_body_parts()
*/
