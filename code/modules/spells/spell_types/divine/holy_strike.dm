/datum/action/cooldown/spell/ravox/judgement
	name = "Holy Strike"
	desc = "Bless your next strike"
	button_icon_state = "judgement"
	sound = 'sound/magic/battletrance.ogg'
	glow_intensity = GLOW_INTENSITY_LOW

	click_to_activate = FALSE
	cast_range = SPELL_RANGE_ADJACENT
	self_cast_possible = TRUE

	primary_resource_cost = SPELLCOST_MIRACLE

	secondary_resource_cost = SPELLCOST_CANTRIP

	invocation_type = INVOCATION_SHOUT
	invocations = list("Bless my strike!")

	charge_required = FALSE
	cooldown_time = 30 SECOUND

	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC | SPELL_REQUIRES_HUMAN | SPELL_REQUIRES_SAME_Z

/datum/action/cooldown/spell/ravox/judgement/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/user = owner
	if(!isliving(user))
		return FALSE
	user.apply_status_effect(/datum/status_effect/judgement, user.get_active_held_item())
	return TRUE

/atom/movable/screen/alert/status_effect/buff/judgement
	name = "Holy Strike"
	desc = "Your next attack deals extra damage."
	icon_state = "judgement"


		var/mob/living/carbon/human/caster
		if (ishuman(firer))
			caster = firer
			switch(caster.patron.type)
				if(/datum/patron/divine/undivided)
					damage += 15 // just more raw damage. As mentioned in UNDIVIDED. Our generics are better as a trade off of not having higher tier uniques.
					H.visible_message(span_warning("Holy light slams into [H] with force!"), span_warning("Holy light slams into me with force!"))
				if(/datum/patron/divine/astrata)
					if(istype(H.patron, /datum/patron/inhumen/matthios))
						H.visible_message(span_warning("[H] is engulfed in flames!"), span_warning("Astrata's <b>hatred</b> sets me aflame!"))
						H.adjust_fire_stacks(3) //ANCIENT ENEMY I DO NOT FEAR YOU
						H.ignite_mob()
					else
						H.visible_message(span_warning("[H] is engulfed in flames!"), span_warning("Astrata's fury sets me aflame!"))
						H.adjust_fire_stacks(2) //Remains regular, setting everyone on fire is funnier
						H.ignite_mob()
				if(/datum/patron/divine/abyssor)
					H.visible_message(span_warning("Water seeps from [H]'s lips!"), span_warning("Choking water in my lungs!"))
					H.Dizzy(5)
					H.emote("drown")
				if(/datum/patron/divine/dendor)
					H.Slowdown(2) // Shared with Ravox cuz immobilize + offbal is 2 strong
					H.visible_message(span_warning("Roots coil around [H]'s legs!"), span_warning("Roots tangle around my legs!"))
				if(/datum/patron/divine/necra)
					if((H.mob_biotypes & MOB_UNDEAD) || HAS_TRAIT(H, TRAIT_DEATHLESS)) //DEATH TO THE DEATHLESS, NECRA HATES YOU.
						H.adjust_fire_stacks(4, /datum/status_effect/fire_handler/fire_stacks/divine)
						H.ignite_mob()
						H.visible_message(span_warning("[H] is rebuked by Divine Scorn!"), span_warning("The Undermaiden's <b>scornful</b> gaze rebukes me!"))
				if(/datum/patron/divine/pestra)
					H.vomit(stun = 0)
					H.adjustToxLoss(10)
					H.visible_message(span_warning("[H] expels some leeches out of them!"), span_warning("Something roils within me!"))
					new /obj/item/natural/worms/leech(get_turf(H))
				if(/datum/patron/divine/eora)
					H.blur_eyes(10)
				if(/datum/patron/divine/noc)
					H.visible_message(span_warning("Moonlight engulfs [H]"), span_warning("Moonlight engulfs me!"))
					damage += (caster.get_stat(STATKEY_INT) * 2)
				if(/datum/patron/divine/ravox)
					H.Slowdown(2)
					H.visible_message(span_warning("Divine chains briefly coil around [H]'s legs!"), span_warning("Divine chains briefly shackle around my legs!"))
				if(/datum/patron/divine/malum)
					H.adjustBruteLoss(10) //Think of it like hammering into you, it was straight direct armor-peircing burn damage before and could crit you insanely fast
					H.visible_message(span_warning("[H] is hammered with divine force!"), span_warning("Malum's disappointment hammers into me!"))
					//He's not mad, he's not proud, he's not hateful, he's as neutrally disappointed in you as one can be. (Its also funnier this way)
	else
		return
