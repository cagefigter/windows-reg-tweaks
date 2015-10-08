Dim hideupdates(9)

hideupdates(0) = "KB2952664"
hideupdates(1) = "KB2990214"
hideupdates(2) = "KB3021917"
hideupdates(3) = "KB3035583"
hideupdates(4) = "KB3068708"
hideupdates(5) = "KB2977759"
hideupdates(6) = "KB3075249"
hideupdates(7) = "KB3080149"
hideupdates(8) = "KB3050265"
hideupdates(9) = "KB3022345"


set updateSession = createObject("Microsoft.Update.Session")
set updateSearcher = updateSession.CreateupdateSearcher()

Set searchResult = updateSearcher.Search("IsInstalled=0 and Type='Software'")

For i = 0 To searchResult.Updates.Count-1
set update = searchResult.Updates.Item(i)
For j = LBound(hideupdates) To UBound(hideupdates)
'MsgBox hideupdates(j)
if instr(1, update.Title, hideupdates(j), vbTextCompare) = 0 then
  'Wscript.echo "No match found for " & hideupdates(j)
else
Wscript.echo "Hiding " & hideupdates(j)
update.IsHidden = True
end if
Next