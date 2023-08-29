function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Both Opponents Sing' then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false);
		end
	end
end
