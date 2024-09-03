function onCreate()
    for unspawnNotes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',unspawnNotes,'noteType') == 'Invisible Hurt Note' then
            setPropertyFromGroup('unspawnNotes', unspawnNotes,'noteType','Hurt Note')
            setPropertyFromGroup('unspawnNotes', unspawnNotes,'visible',false)
        end
    end
end