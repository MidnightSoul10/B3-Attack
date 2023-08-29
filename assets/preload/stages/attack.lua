
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx =  1000;
local yy =  1050;
local xx2 = 1400;
local yy2 = 1050;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
	makeLuaSprite('backbackground','attack/monotoneback',0,0)
	addLuaSprite('backbackground')

	makeAnimatedLuaSprite('peopleloggo','attack/crowd',850,850)
	addAnimationByPrefix('peopleloggo','bop','tess n gus fring instance 1',24,false)
	addLuaSprite('peopleloggo')

	makeLuaSprite('actualbackground','attack/fg',0,0)
	addLuaSprite('actualbackground')
	
	makeAnimatedLuaSprite('nickt','attack/nick t',600,700)
	addAnimationByPrefix('nickt','bop','nick t idle',24,false)
	addAnimationByPrefix('nickt','talk','nick t animation',24,false)
	addLuaSprite('nickt')

	makeAnimatedLuaSprite('toogusorange','attack/offbi',1250,625)
	addAnimationByPrefix('toogusorange','bop','offbi',24,false)
	addLuaSprite('toogusorange')
	
	makeAnimatedLuaSprite('toogusblue','attack/orbyy',850,665)
	addAnimationByPrefix('toogusblue','bop','orbyy',24,false)
	addAnimationByPrefix('toogusblue','shutup','shutup',24,false)
    addOffset('toogusblue','bop',0,0)
    addOffset('toogusblue','shutup',130,0)
	addLuaSprite('toogusblue')

	makeAnimatedLuaSprite('thebackground','attack/loggoattack',950,775)
	addAnimationByPrefix('thebackground','bop','loggfriend',24,false)
	addLuaSprite('thebackground')

	makeAnimatedLuaSprite('crowd','attack/cooper',1950,750)
	addAnimationByPrefix('crowd','bop','bg seat 1 instance 1',24,false)
	addLuaSprite('crowd')
	
	makeLuaSprite('backlights','attack/backlights',0,0)
	setBlendMode('backlights','add')
	addLuaSprite('backlights')

	makeLuaSprite('lamp','attack/lamp',0,0)
	addLuaSprite('lamp')

    
	makeLuaSprite('lightover','attack/frontlight',0,0)
    setBlendMode('lightover','add')
	addLuaSprite('lightover',true)

    makeLuaSprite('pruple','attack/purple',0,0)
	addLuaSprite('pruple',true)
end
orbybop = true
nickt = true
function onBeatHit()
	if curBeat % 2 == 0 then
		playAnim('peopleloggo','bop',false)
		playAnim('crowd','bop',false)
        if nickt then
		playAnim('nickt','bop',false)
        end
	end
    if orbybop then
		playAnim('toogusblue','bop',false)
    end
	playAnim('toogusorange','bop',false)
    playAnim('thebackground','bop',false)

end
function onEvent(n,v1,v2)
    if n == 'Orbyy' then
        orbybop = false
        playAnim('toogusblue','shutup',true)
    end
    if n == 'Orbyy2' then
        orbybop = true
    end
    if n == 'Forehead' then
        nickt = false
        playAnim('nickt','talk',true)
        doTweenAlpha('g1','camHUD',0,0.4)
        doTweenAlpha('g2','toogusorange',0.1,0.4)
        doTweenAlpha('g3','toogusblue',0.1,0.4)
        doTweenAlpha('g4','thebackground',0.1,0.4)
        doTweenAlpha('g5','dad',0.25,0.4)
        doTweenAlpha('g6','boyfriend',0.25,0.4)
        doTweenAlpha('g7','biddle',0.1,0.4)
        doTweenAlpha('g8','gf',0.1,0.4)
    end
    if n == 'Forehead2' then
        nickt = true
        doTweenAlpha('g1','camHUD',1,0.4)
        doTweenAlpha('g2','toogusorange',1,0.4)
        doTweenAlpha('g3','toogusblue',1,0.4)
        doTweenAlpha('g4','thebackground',1,0.4)
        doTweenAlpha('g5','dad',1,0.4)
        doTweenAlpha('g6','boyfriend',1,0.4)
        doTweenAlpha('g7','biddle',1,0.4)
        doTweenAlpha('g8','gf',1,0.4)
    end
end



function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

           
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    if curBeat == 64 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 80 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 95 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1000
        yy = 900
        xx2 = 1000
        yy2 = 900
    end
    if curBeat == 99 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        orbybop = true
        xx = 1000
        yy = 1050
        xx2 = 1400  
        yy2 = 1050
    end
    if curBeat == 196 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 229 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 276 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 292 then
        setProperty('defaultCamZoom',0.75)
		followchars = true
        xx = 1000
        yy = 1050
        xx2 = 1400  
        yy2 = 1050
    end
    if curBeat == 324 then
        setProperty('defaultCamZoom',0.7)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    if curBeat == 355 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1000
        yy = 900
        xx2 = 1000
        yy2 = 900
    end
    if curBeat == 360 then
        setProperty('defaultCamZoom',0.6)
		followchars = true
        xx = 1225
        yy = 1000
        xx2 = 1225
        yy2 = 1000
    end
    
    
end