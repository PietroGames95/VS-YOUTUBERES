function onEvent(name, value1, value2)
	if name == 'POTENTEIMAGEN' then
		colour = tonumber(value2);
		duration = tonumber(value1);
		if colour == 1 then
			makeLuaSprite('unopotenteeeaparece', 'unopotenteee', 140, 230);
			setObjectCamera('unopotenteeeaparece', 'hud');
			addLuaSprite('unopotenteeeaparece', true);
			doTweenColor('unopotenteeecolor', 'unopotenteeeaparece', 'FFFFFF', 0.01, 'linear');
			doTweenAlpha('unopotenteeealpha', 'unopotenteeeaparece', 0, duration, 'linear');
		end
		if colour == 2 then
			makeLuaSprite('dospotenteaparece', 'ready', 250, 230);
			setObjectCamera('dospotenteaparece', 'hud');
			addLuaSprite('dospotenteaparece', true);
			doTweenColor('dospotentecolor', 'dospotenteaparece', 'FFFFFF', 0.01, 'linear');
			doTweenAlpha('dospotentealpha', 'dospotenteaparece', 0, duration, 'linear');
		end
		if colour == 3 then
			makeLuaSprite('trespotenteaparece', 'set', 250, 230);
			setObjectCamera('trespotenteaparece', 'hud');
			addLuaSprite('trespotenteaparece', true);
			doTweenColor('trespotentecolor', 'trespotenteaparece', 'FFFFFF', 0.01, 'linear');
			doTweenAlpha('trespotentealpha', 'trespotenteaparece', 0, duration, 'linear');
		end
		if colour == 4 then
			makeLuaSprite('cuatropotenteaparece', 'go', 250, 230);
			setObjectCamera('cuatropotenteaparece', 'hud');
			addLuaSprite('cuatropotenteaparece', true);
			doTweenColor('cuatropotentecolor', 'cuatropotenteaparece', 'FFFFFF', 0.01, 'linear');
			doTweenAlpha('cuatropotentealpha', 'cuatropotenteaparece', 0, duration, 'linear');
		end
    end
end