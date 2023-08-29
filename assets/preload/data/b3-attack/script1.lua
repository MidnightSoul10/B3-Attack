function onCreatePost()
	runHaxeCode([[
		biddle = new Character(1650, 900, 'biddle');
		game.addBehindBF(biddle);
		game.variables.set('biddle',biddle);
	]]);
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % biddle.danceEveryNumBeats == 0 && biddle.animation.curAnim != null && !StringTools.startsWith(biddle.animation.curAnim.name, 'sing') && !biddle.stunned)
		{
			biddle.dance()
		}
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % biddle.danceEveryNumBeats == 0 && biddle.animation.curAnim != null && !StringTools.startsWith(biddle.animation.curAnim.name, 'sing') && !biddle.stunned)
		{
			biddle.dance();
		}
	]]);
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (!game.controls.NOTE_LEFT && !game.controls.NOTE_DOWN && !game.controls.NOTE_UP && !game.controls.NOTE_RIGHT && game.startedCountdown && game.generatedMusic)
		{
			if (!biddle.stunned && biddle.holdTimer > Conductor.stepCrochet * 0.0011 * biddle.singDuration && StringTools.startsWith(biddle.animation.curAnim.name, 'sing') && !StringTools.endsWith(biddle.animation.curAnim.name, 'miss'))
			{
				biddle.dance();
			}
		}
	]]);
end
