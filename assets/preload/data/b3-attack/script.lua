local fakeNotes = {}
function getModFolder()
	local dir = 'mods'
	if #currentModDirectory > 0 and currentModDirectory ~= nil then
		dir = dir..'/'..currentModDirectory
	end
	return dir
end
local fakeNoteCol = {
	[0] = 'purple',
	[1] = 'blue',
	[2] = 'green',
	[3] = 'red'
}
local fakeNoteDir = {
	[0] = 'LEFT',
	[1] = 'DOWN',
	[2] = 'UP',
	[3] = 'RIGHT'
}
local fakeStrumDirOffCon = {
	[0] = {48, 46},
	[1] = {52, 49},
	[2] = {50, 48},
	[3] = {47, 49}
}
howManLoop = 0
function onCreate()
	local json = dofile('mods/' .. currentModDirectory .. '/scripts/JSONLIB.lua')
	jsonTble = json.parse(getTextFromFile('data/' .. songPath .. '/' .. songPath .. '-other.json'))
	for i = 1, #jsonTble.song.notes do 
		if #jsonTble.song.notes[i].sectionNotes > 0 then
			for b = 1, #jsonTble.song.notes[i].sectionNotes do
				howManLoop = howManLoop + 1
				fakeNotes[howManLoop] = {
					strumTime = 0,
					noteType = '',
					direction = 0,
					mustHitSection = false,
					speedMult = 1,
					wasHitGood = false,
					canBeHit = true,
					earlHitMult = 0.5,
					lateHitMult = 1,
					sustainLength = 0,
					sustainTimes = {},
					sustainWasHit = {}
				}
				fakeNotes[howManLoop].strumTime = jsonTble.song.notes[i].sectionNotes[b][1]
				fakeNotes[howManLoop].direction = (jsonTble.song.notes[i].sectionNotes[b][2]%4)
				fakeNotes[howManLoop].sustainLength = jsonTble.song.notes[i].sectionNotes[b][3]
				fakeNotes[howManLoop].noteType = jsonTble.song.notes[i].sectionNotes[b][4]
				fakeNotes[howManLoop].mustHitSection = jsonTble.song.notes[i].sectionNotes[b][5]
			end
		end
	end
	for i in pairs(fakeNotes) do
		sustLen = fakeNotes[i].sustainLength/stepCrochet
		sustFloor = math.floor(sustLen)
		if sustFloor > 0 then
			for b = 0, sustFloor-1 do
				fakeNotes[i].sustainTimes[b] = fakeNotes[i].strumTime + (stepCrochet * b) + (stepCrochet/math.round(getProperty('songSpeed'), 2))
				fakeNotes[i].sustainWasHit[b] = false
			end
		end
	end
end

function onCreatePost()
	spawnFakeNote()
end

function spawnFakeNote()
	for i in pairs(fakeNotes) do
		makeAnimatedLuaSprite('fakeNote' .. i, 'NOTE_assets')
		addAnimationByPrefix('fakeNote' .. i, fakeNoteCol[fakeNotes[i].direction] .. 'Scroll', fakeNoteCol[fakeNotes[i].direction] .. '0', 24, true)
		addLuaSprite('fakeNote' .. i)
		setProperty('fakeNote' .. i .. '.alpha', 0.35)
		if fakeNotes[i].noteType == 'No Animation' then
			setProperty('fakeNote' .. i .. '.x', getPropertyFromGroup('playerStrums', fakeNotes[i].direction, 'x'))
		elseif fakeNotes[i].noteType == 'GF Sing' then
			setProperty('fakeNote' .. i .. '.x', getPropertyFromGroup('opponentStrums', fakeNotes[i].direction, 'x'))
		end
		scaleObject('fakeNote'.. i, 0.7, 0.7)
		setObjectCamera('fakeNote' .. i, 'hud')
		setObjectOrder('fakeNote' .. i, getObjectOrder('opponentStrums') + 2)
		
	end
end

function onUpdate(e)
	for i in pairs(fakeNotes) do
		if luaSpriteExists('fakeNote' .. i) then
			setProperty('fakeNote' .. i .. '.y', getProperty('strumLine.y') + ((0.45 * (downscroll and 1 or -1)) * (getSongPosition() - fakeNotes[i].strumTime) * getProperty('songSpeed')))
		end
		if fakeNotes[i].strumTime <= getSongPosition() and not fakeNotes[i].wasHitGood then
			removeLuaSprite('fakeNote' .. i)
			fakeGoodNoteHit(i, (fakeNotes[i].direction), fakeNotes[i].noteType, false)
			fakeNotes[i].wasHitGood = true
		end
		for b in pairs(fakeNotes[i].sustainTimes) do
			if fakeNotes[i].sustainTimes[b] <= getSongPosition() and not fakeNotes[i].sustainWasHit[b] then
				fakeGoodNoteHit(i, fakeNotes[i].direction, fakeNotes[i].noteType, true)
				fakeNotes[i].sustainWasHit[b] = true
			end
		end
	end
end

function fakeGoodNoteHit(id, dir, nt, sus)
	if nt == 'No Animation' then
		runHaxeCode([[
			biddle.playAnim(game.singAnimations[]]..dir..[[], true);
			biddle.holdTimer = 0;
		]])
	elseif nt == 'GF Sing' then
		playAnim('gf', getProperty('singAnimations[' .. dir .. ']'), true)
		setProperty('gf.holdTimer', 0)
	end

end

function math.round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate  this shit is only used once very cool!!!
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end