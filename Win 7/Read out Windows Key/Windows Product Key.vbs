Set WshShell = CreateObject("WScript.Shell")
Key = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\"
DigitalID = WshShell.RegRead(key & "DigitalProductId")

ProductName = "Product Name: " & WshShell.RegRead(Key & "ProductName") & vbNewLine
ProductID = "Product ID: " & WshShell.RegRead(Key & "ProductID") & vbNewLine
ProductKey = "Installed Key: " & ConvertToKey(DigitalID)
ProductID = ProductName & ProductID & ProductKey

If vbYes = MsgBox(ProductId & vblf & vblf & "Save to a File ?", vbYesNo + vbQuestion, "Windows Key Information") then
   Save ProductID
End if

Function ConvertToKey(Key)
    Const KeyOffset = 52
    isWin8 = (Key(66) \ 6) And 1
    Key(66) = (Key(66) And &HF7) Or ((isWin8 And 2) * 4)
    i = 24
    Chars = "BCDFGHJKMPQRTVWXY2346789"
    Do
        Cur = 0
        X = 14
        Do
            Cur = Cur * 256
            Cur = Key(X + KeyOffset) + Cur
            Key(X + KeyOffset) = (Cur \ 24)
            Cur = Cur Mod 24
            X = X -1
        Loop While X >= 0
        i = i -1
        KeyOutput = Mid(Chars, Cur + 1, 1) & KeyOutput
        Last = Cur
    Loop While i >= 0
    If (isWin8 = 1) Then
        keypart1 = Mid(KeyOutput, 2, Last)
        insert = "N"
        KeyOutput = Replace(KeyOutput, keypart1, keypart1 & insert, 2, 1, 0)
        If Last = 0 Then KeyOutput = insert & KeyOutput
    End If
    a = Mid(KeyOutput, 1, 5)
    b = Mid(KeyOutput, 6, 5)
    c = Mid(KeyOutput, 11, 5)
    d = Mid(KeyOutput, 16, 5)
    e = Mid(KeyOutput, 21, 5)
    ConvertToKey = a & "-" & b & "-" & c & "-" & d & "-" & e
End Function

Function Save(Data)
    Const ForWRITING = 2
    Const asASCII = 0
    Dim fso, f, fName, ts
    fName = "Windows Key.txt"
    Set fso = CreateObject("Scripting.FileSystemObject")
    fso.CreateTextFile fName
    Set f = fso.GetFile(fName)
    Set f = f.OpenAsTextStream(ForWRITING, asASCII)
    f.Writeline Data
    f.Close
End Function