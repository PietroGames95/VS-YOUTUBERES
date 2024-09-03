function onCreate()
        makeLuaText('liri', '', 900, 200, 530)
    setTextSize('liri', 30)
    setObjectCamera('liri', 'other')
    addLuaText('liri', true)
    setTextFont('liri', 'Ticketing.otf')
    setTextAlignment('liri', 'center')
        end
        function onEvent(name, value1, value2)
            if name == 'Lyrics' then
            setTextString('liri', value1)
            end
        end