--[[ made by Laztrix#5670 

please credit if you gonna use this as a mod that will be public

]]

local timeEffect = 0.75
local zoomMulti = {0.015,0.015}
local alphaTrail = 0.8
function onSongStart()
	if songName == 'Who' or songName == 'Voting-Time' or songName == 'Sussus Nuzzus' or songName == 'Idk' then
		noGhost = true
	end
	makeTrailEffect()
end
function onEvent(n,v1,v2)
	if n == 'Change Character' then
		isTrail = false
		runHaxeCode([[
			game.remove(trailBF);
			game.remove(trailDad);
			game.remove(trailGF);
		]])
		runTimer('characterChanged',0.2)
	end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
if not noGhost then
	if not isSustainNote and not gfSection or not isSustainNote and not noteType == 'GF Sing' then
		if passDirectionBF ~= nil then
		runHaxeCode([[
			trailBF.playAnim(game.singAnimations[]]..passDirectionBF..[[], true);
		]])
		setProperty('trailBF.alpha',alphaTrail)
		doTweenAlpha('betrailbf','trailBF',0,timeEffect,'linear')
		cancelTimer('bfframed')
		triggerEvent("Add Camera Zoom",zoomMulti[0],zoomMulti[1])
		end
		passDirectionBF = direction
		runTimer('bfframed', 0.025)
	end
	if not isSustainNote and gfSection or not isSustainNote and noteType == 'GF Sing' then
		if passDirectionGF ~= nil then
		runHaxeCode([[
			trailGF.playAnim(game.singAnimations[]]..passDirectionGF..[[], true);
		]])
		cancelTimer('gfframed')
		setProperty('trailGF.alpha',alphaTrail)
		doTweenAlpha('betrailgf','trailGF',0,timeEffect,'linear')
		triggerEvent("Add Camera Zoom",zoomMulti[0],zoomMulti[1])
		end
		passDirectionGF = direction
		runTimer('gfframed', 0.025)
	end
end
end
function opponentNoteHit(id, direction ,noteType, isSustainNote)
if not noGhost then
	if not isSustainNote and not gfSection or not isSustainNote and not noteType == 'Opponent 2 Sing' and not gfSection then
		if passDirectionDad ~= nil then
    	runHaxeCode([[
    	    trailDad.playAnim(game.singAnimations[]]..passDirectionDad..[[], true);
    	]])
		cancelTimer('dadframed')
		setProperty('trailDad.alpha',alphaTrail)
		doTweenAlpha('betraildad','trailDad',0,timeEffect,'linear')
		triggerEvent("Add Camera Zoom",zoomMulti[0],zoomMulti[1])
		end
		passDirectionDad = direction
		runTimer('dadframed', 0.01)
	end
	if not isSustainNote and gfSection or not isSustainNote and noteType == 'Opponent 2 Sing' or noteType == 'Both Opponents Sing' and songPath == 'double-kill' then
		if passDirectionGF ~= nil then
    	runHaxeCode([[
    	    trailGF.playAnim(game.singAnimations[]]..passDirectionGF..[[], true);
    	]])
		cancelTimer('gfframed')
		setProperty('trailGF.alpha',alphaTrail)
		doTweenAlpha('betrailgf','trailGF',0,timeEffect,'linear')
		triggerEvent("Add Camera Zoom",zoomMulti[0],zoomMulti[1])
		end
		passDirectionGF = direction
		runTimer('gfframed', 0.01)
	end
end
end
function onTimerCompleted(t)
    if t == 'bfframed' then
        passDirectionBF = nil
    end

    if t == 'dadframed' then
        passDirectionDad = nil
    end

	if t == 'gfframed' then
        passDirectionGF = nil
    end

	if t == 'characterChanged' then
		makeTrailEffect()
	end
end

function makeTrailEffect()
	isTrail = true
	runHaxeCode([[
	// getting character original position
		BFPos = [game.boyfriend.x,game.boyfriend.y];
      	DadPos = [game.dad.x,game.dad.y];
		GFPos = [game.gf.x,game.gf.y];

	// new characters for the trails
		trailBF = new Boyfriend(BFPos[0], BFPos[1], ']]..boyfriendName..[[');
		game.addBehindBF(trailBF);

		trailDad = new Character(DadPos[0], DadPos[1], ']]..dadName..[[');
		game.addBehindDad(trailDad);

		

	// set the variable so you can mess it with setProperty stuff
		game.variables.set('trailDad', trailDad);
        game.variables.set('trailBF', trailBF);

	// grrr
		trailDad.alpha = 0;
		trailBF.alpha = 0;

		if (getVar('isDBTime'))
			{
				trailGF = new Character(1300, 650, 'blackdk');
				game.addBehindGF(trailGF);
				game.variables.set('trailGF', trailGF);
				trailGF.alpha = 0;

			}
	]])
	setProperty('trailDad.color',getIconColor('dad'))
	setProperty('trailGF.color',getIconColor('gf'))
	setProperty('trailBF.color',getIconColor('boyfriend'))

end
function onCreatePost()
	if songPath == 'double-kill' then
		runHaxeCode([[
			setVar('isDBTime',true)
		]])
	end
end
function onUpdatePost()
	if isTrail then
	runHaxeCode([[
	// preventing the characters to go back playing idle animation
		trailGF.holdTimer = 0;
		trailDad.holdTimer = 0;
		trailBF.holdTimer = 0;
	]])
	end
end

function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

--[[ made by Laztrix#5670 

please credit if you gonna use this as a mod that will be public

]]