/spell/aoe_turf/knock
	name = "Knock"
	desc = "This spell opens nearby doors and does not require wizard garb."

	school = "transmutation"
	charge_max = 100
	spell_flags = 0
	invocation = "AULIE OXIN FIERA"
	invocation_type = SpI_WHISPER
	range = 3
	cooldown_min = 20 //20 deciseconds reduction per rank

	hud_state = "wiz_knock"

/spell/aoe_turf/knock/cast(list/targets)
	for(var/turf/T in targets)
		for(var/obj/machinery/door/door in T.contents)
			spawn(1)
				if(istype(door,/obj/machinery/door/airlock))
					var/obj/machinery/door/airlock/AL = door //casting is important
					AL.locked = 0
				door.open()
	return


//Construct version
/spell/aoe_turf/knock/harvester
	name = "Disintegrate Doors"
	desc = "No door shall stop you."

	spell_flags = CONSTRUCT_CHECK

	charge_max = 100
	invocation = ""
	invocation_type = "silent"
	range = 5

	hud_state = "const_knock"

/spell/aoe_turf/knock/harvester/cast(list/targets)
	for(var/turf/T in targets)
		for(var/obj/machinery/door/door in T.contents)
			spawn door.cultify()
	return

/spell/aoe_turf/construct_screech
	name = "Screech"
	desc = "An extremely loud shriek."
	school = "destruction"
	charge_max = 60
	spell_flags = 0
	invocation = "none"
	invocation_type = SpI_NONE
	hud_state = "artificer"
	range = 6

/spell/aoe_turf/construct_screech/cast(list/targets)
	src << "\red You let out a loud shriek."
	for(var/turf/T in targets)
		for(var/obj/machinery/door/window/WD in T.contents)
			if(prob(60))
				WD.take_damage(15, 0)
			if(prob(40))
				WD.take_damage(25, 0)
			if(prob(20))
				WD.take_damage(35, 0)
			if(prob(10))
				WD.take_damage(45, 0)
		for(var/obj/structure/window/W in T.contents)
			if(prob(60))
				W.take_damage_remote(5)
			if(prob(40))
				W.take_damage_remote(10)
			if(prob(20))
				W.take_damage_remote(15)
			if(prob(10))
				W.take_damage_remote(20)
		for(var/obj/machinery/light/L in T.contents)
			if(prob(20))
				L.damaged_remote(50)
		for(var/mob/living/M in T.contents)
			shake_camera(M,15)
			if(!(istype(M,/mob/living/simple_animal/construct)))
				M << "<span class='warning'><font size='3'><b>Your mind is assaulted by an other worldly shriek.</font></b></span>"
		for(var/mob/living/simple_animal/construct/harvester/forgotten/H in T.contents)
			playsound(H.loc, 'sound/effects/Construct_Screech.ogg', 100, 1)
