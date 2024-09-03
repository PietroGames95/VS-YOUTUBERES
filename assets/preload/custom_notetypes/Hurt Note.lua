local noteOpacity = 50
function onCreate()
    for unspawnNotes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',unspawnNotes,'noteType') == 'Hurt Note' then
            setPropertyFromGroup('unspawnNotes',unspawnNotes,'ignoreNote',true)
            setPropertyFromGroup('unspawnNotes',unspawnNotes,'alpha',0.5)
        end
    end
end
function onUpdatePost()
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'Hurt Note' then
            setPropertyFromGroup('notes',notes,'alpha',noteOpacity/100)
        end
    end
end