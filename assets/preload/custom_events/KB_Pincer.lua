local style = 0
local enableModChart =false
local defaultX = {}
local defaultY = {}
local enablePincerFix = {false,false,false,false}
local pincerNotes = {4,5,6,7}
function onCreate()
    precacheImage('hazard/qt-port/pincer-close')
    precacheImage('hazard/qt-port/pincer-open')
    for pincer = 1,4 do
        local name = 'KBPincer'..pincer
        makeLuaSprite(name,'hazard/qt-port/pincer-close',0,0)
        setObjectCamera(name,'hud')
        if not downscroll then
            setProperty(name..'.angle',90)
            setProperty(name..'.offset.x',220)
            setProperty(name..'.offset.y',250)
        else
            setProperty(name..'.angle',270)
            setProperty(name..'.offset.x',195)
            setProperty(name..'.offset.y',-85)
        end
    end
end
function onCreatePost()
    for strumLine = 0,7 do
        table.insert(defaultX,getPropertyFromGroup('strumLineNotes',strumLine,'x'))
        table.insert(defaultY,getPropertyFromGroup('strumLineNotes',strumLine,'y'))
    end
end
function onUpdate()
    for pincers = 1,4 do
        setProperty('KBPincer'..pincers..'.x',getPropertyFromGroup('strumLineNotes',pincerNotes[pincers],'x'))
        if enablePincerFix[pincers] == true then
            setProperty('KBPincer'..pincers..'.y',getPropertyFromGroup('strumLineNotes',pincerNotes[pincers],'y'))
        end
    end
    if enableModChart then
        setProperty('camHUD.angle',math.sin((getSongPosition()/(stepCrochet*4))*math.pi) * 3)
    end
end
function onTweenCompleted(tag)
    if string.find(tag,'KBPincerYBye',0,true) then
        for pincers = 1,4 do
            if tag == 'KBPincerYBye'..pincers then
                removeLuaSprite('KBPincer'..pincers,false)
            end
        end
    end
end
function pincer(id,goAway)
    local downvalue = 1
    if downscroll then
        downvalue = -1
    end
    local pincer = 1
    local note = 0
    if id == 1 then
        --note = 4
    elseif id == 2 then
        pincer = 2
        --note = 4
    elseif id == 3 then
        pincer = 3
        --note = 6
    elseif id == 4 then
        pincer = 4
        --note = 7
    elseif id == 5 then
        pincer = 2
    elseif id == 6 then
        pincer = 2
        --note = 3
    end
    note = pincerNotes[pincer]
    local name = 'KBPincer'..pincer
    cancelTween('KBPincerYBye'..pincer)
    cancelTween('KBPincerYHey'..pincer)
    pincerOpen(pincer)
    if not goAway then
        setProperty(name..'.y',getPropertyFromGroup('strumLineNotes',note,'y') - (500 * downvalue))
        addLuaSprite(name,true)
        doTweenY('KBPincerYHey'..pincer,name,getPropertyFromGroup('strumLineNotes',note,'y'),0.3,'elasticOut')
    else
        doTweenY('KBPincerYBye'..pincer,name,getPropertyFromGroup('strumLineNotes',note,'y') - (500 * downvalue),0.3,'backIn')
    end
end
function pincerOpen(pincer)
    table.remove(enablePincerFix,pincer)
    table.insert(enablePincerFix,pincer,false)
    loadGraphic('KBPincer'..pincer,'hazard/qt-port/pincer-open',522,293)
end
function pincerGrab(pincer)
    table.remove(enablePincerFix,pincer)
    table.insert(enablePincerFix,pincer,true)
    cancelTween('KBPincerYHey'..pincer)
    loadGraphic('KBPincer'..pincer,'hazard/qt-port/pincer-close',522,293)
end
function onEvent(name,v1,v2)
    if name == 'KB_Pincer' then
        style = tonumber(v1)
        if style == nil then
            style = 0
        end
        if style == 0 then
            pincer(3,false)
        elseif style == 1 then
            pincerGrab(3)
            local y = 70
            if downscroll then
                y = y *-1
            end
            noteTweenY('modKBTweenY6',6,defaultY[7]+y,0.25,'quadOut')
        elseif style == 2 then
            pincer(3,true)
        elseif style == 3 then
            pincer(1,false)
            pincer(3,false)
        elseif style == 4 then
            pincerGrab(1)
            pincerGrab(3)
            local y = 62
            noteTweenX('modKBTweenX6',6,defaultX[7],0.25,'quadOut')
            noteTweenY('modKBTweenY6',6,defaultY[7],0.25,'quadOut')
            if downscroll then
                y = y *-1
            end
            noteTweenX('modKBTweenX4',4,defaultX[5] - 25,0.25,'quadOut')
            noteTweenY('modKBTweenY4',4,defaultY[5] + y,0.25,'quadOut')

        elseif style == 5 then
            pincer(1,true)
            pincer(3,true)
        elseif style == 6 then
            pincer(1,false)
            pincer(2,false)
            pincer(4,false)
        elseif style == 7 then
            pincerGrab(1)
            pincerGrab(2)
            pincerGrab(4)
            noteTweenX('modKBTweenX4',4,defaultX[5],0.25,'quadOut')
            noteTweenY('modKBTweenY4',4,defaultY[5],0.25,'quadOut')
            local downvalue = 1
            if downscroll then
                downvalue = -1
            end
            noteTweenX('modKBTweenX5',5,defaultX[6] + 11,0.25,'quadOut')
            noteTweenY('modKBTweenY5',5,defaultY[6] + (70 * downvalue),0.25,'quadOut')
            noteTweenX('modKBTweenX7',7,defaultX[8] + 50,0.25,'quadOut')
            noteTweenY('modKBTweenY7',7,defaultY[8] + (40 * downvalue),0.25,'quadOut')
        elseif style == 8 then
            pincer(1,true)
            pincer(2,true)
            pincer(4,true)
        elseif style == 9 then
            for pincers = 1,4 do
                pincer(pincers,false)
            end
        elseif style == 10 then
            local downvalue = 1
            if downscroll then
                downvalue = -1
            end
            for pincers = 1,4 do
                pincerGrab(pincers)
            end
            noteTweenX('modKBTweenX4',4,defaultX[5] - 16,0.25,'quadOut')
            noteTweenY('modKBTweenY4',4,defaultY[5] - (11 * downvalue),0.25,'quadInOut')
            noteTweenAngle('modKBTweenAngle4',4,-40,0.25,'linear')

            noteTweenX('modKBTweenX5',5,defaultX[6],0.25,'quadOut')
            noteTweenY('modKBTweenY5',5,defaultY[6] - (32 * downvalue),0.25,'quadOut')

            noteTweenX('modKBTweenX6',6,defaultX[7],0.25,'quadOut')
            noteTweenY('modKBTweenY6',6,defaultY[7] - (32 * downvalue),0.25,'quadOut')

            noteTweenX('modKBTweenX7',7,defaultX[8] + 16,0.25,'quadOut')
            noteTweenY('modKBTweenY7',7,defaultY[8] - (11 * downvalue),0.25,'quadOut')
            noteTweenAngle('modKBTweenAngle7',7,40,0.25,'linear')
        elseif style == 11 then
            for pincers = 1,4 do
                pincer(pincers,true)
            end
        elseif style == 12 then
            pincer(1,false)
            pincer(4,false)
        elseif style == 13 then
            pincerGrab(1)
            pincerGrab(4)

            noteTweenY('modKBTweenX4',4,defaultY[5] + 75,0.9,'quadInOut')
            noteTweenY('modKBTweenX7',7,defaultY[8]- 75,0.9,'quadInOut')
        elseif style == 14 then
            noteTweenX('modKBTweenX4',4,defaultX[8],0.9,'quadInOut')
            noteTweenX('modKBTweenX7',7,defaultX[5],0.9,'quadInOut')

        elseif style == 15 then
            noteTweenY('modKBTweenY4',4,defaultY[8],0.75,'quadInOut')
            noteTweenY('modKBTweenY7',7,defaultY[5],0.75,'quadInOut')

            noteTweenAngle('modKBTweenAngle4',4,0,0.7,'linear')
            noteTweenAngle('modKBTweenAngle7',7,0,0.7,'linear')

        elseif style == 16 then
            pincer(1,true)
            pincer(2,false)
            pincer(3,false)
            pincer(4,true)
        elseif style == 17 then
            pincerGrab(2)
            pincerGrab(3)
            noteTweenX('modKBTweenX5',5,defaultX[6],0.75,'quadInOut')
            noteTweenX('modKBTweenX6',6,defaultX[7],0.75,'quadInOut')

            noteTweenY('modKBTweenX5',5,defaultY[6] + 75,0.75,'quadInOut')
            noteTweenY('modKBTweenX6',6,defaultY[7]- 75,0.75,'quadInOut')

        elseif style == 18 then
            noteTweenX('modKBTweenX5',5,defaultX[7],0.9,'quadInOut')
            noteTweenX('modKBTweenX6',6,defaultX[6],0.9,'quadInOut')
        elseif style == 19 then
            noteTweenY('modKBTweenY5',5,defaultY[7],0.75,'quadInOut')
            noteTweenY('modKBTweenY6',6,defaultY[6],0.75,'quadInOut')
        elseif style == 20 then
            pincer(2,true)
            pincer(3,true)

        elseif style == 21 then
            for strumLine = 0,7 do
                noteTweenX('modKBTweenX'..strumLine,strumLine,defaultX[strumLine + 1],0.75,'quadinOut')
                noteTweenY('modKBTweenY'..strumLine,strumLine,defaultY[strumLine + 1],0.75,'quadinOut')
            end
        elseif style == 22 then
            table.remove(pincerNotes,1)
            table.insert(pincerNotes,1,0)
            if middlescroll then
                table.remove(pincerNotes,4)
                table.insert(pincerNotes,4,3)
            end

            pincer(1,false)
            pincer(4,false)
        elseif style == 23 then
            enableModChart = true
            pincerGrab(1)
            pincerGrab(4)

        elseif style == 24 then
            enableModChart = false
            doTweenAngle('modKBcamHUD','camHUD',0,0.25,'quadOut')
            pincer(1,true)
            pincer(4,true)

            table.remove(pincerNotes,1)
            table.insert(pincerNotes,1,4)
            if middlescroll then
                table.remove(pincerNotes,4)
                table.insert(pincerNotes,4,7)
            end
        end
    end
end