
'''''''''''''''''''''''''''''''''''''''
''' MS ACCESS
'''''''''''''''''''''''''''''''''''''''

Option Compare Database
Option Explicit

Private Sub ParsedOutput_Click()
    Call WriteText
End Sub

Private Sub TXTImport_Click()
On Error GoTo ErrHandle
    Dim db As Database
    
    Set db = CurrentDb
    ' CLEAN OUT TABLE
    db.Execute "DELETE FROM InputText", dbFailOnError
    
    ' IMPORT TEXT FILE INTO TABLE
    DoCmd.TransferText acImportFixed, "InputTextSpecs", "InputText", Application.CurrentProject.Path & "\TEXT\Input.txt", False
    
    Set db = Nothing
    
    MsgBox "Successfully parsed and outputted file!", vbInformation, "OUTPUT"
    Exit Sub
    
ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Exit Sub
End Sub


Public Function CleanText(inputString As String) As String
On Error GoTo ErrHandle
    Dim regEx As New RegExp
    Dim strTXT As String, inner As String
    Const ForReading = 1
       
    ' SET REGEX OBJECT
    With regEx
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .Pattern = "[^A-Za-z]"
    End With
    
    ' REPLACE SPECIAL CHARACTERS/NUMBERS
    inner = regEx.Replace(inputString, " ")
            
    inner = Replace(inner, "      ", " ")
    inner = Replace(inner, "  ", " ")
    inner = Trim(Replace(inner, " s ", "'s "))
    inner = Trim(Replace(inner, "o er", "o'er"))
       
    CleanText = inner
    Exit Function
    
ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
    
End Function

Public Function WriteText()
On Error GoTo ErrHandle
    Dim db As Database, rst As Recordset
    Dim objFSO As Object, ofile As Object
    Dim strTXT As String: strTXT = ""
    Const fsoForWriting = 2
    Const fsoForAppend = 8
    
    ' OPEN QUERY RECORDSET AND CONCATENATE TO STRING
    Set db = CurrentDb
    Set rst = db.OpenRecordset("InputTextQ")
        
    rst.MoveFirst
    Do While Not rst.EOF
        strTXT = strTXT & rst!NewLine & vbNewLine
        rst.MoveNext
    Loop
        
    rst.Close
    Set rst = Nothing
    Set db = Nothing
        
    ' OPEN TEXT FILE
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set ofile = objFSO.OpenTextFile(Application.CurrentProject.Path & "\TEXT\Output_ACC.txt", fsoForWriting, True)
    
    ' WRITE TO FILE
    ofile.WriteLine strTXT
        
    ' CLOSE FILE
    ofile.Close
    Set ofile = Nothing
    Set objFSO = Nothing
    
    MsgBox "Successfully parsed and outputted file!", vbInformation, "OUTPUT"
    
    Exit Function
    
ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Set rst = Nothing
    Set db = Nothing
    
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
End Function


'''''''''''''''''''''''''''''''''''''''
''' MS EXCEL
'''''''''''''''''''''''''''''''''''''''
Option Explicit

Public Sub TextParse()
On Error GoTo ErrHandle
    Call WriteText
    MsgBox "Successfully parsed and outputted text file!", vbInformation, "TEXT PARSING"
    Exit Sub
    
ErrHandle:
    MsgBox Err.Number & " - " * Err.Description
    Exit Sub
End Sub

Public Function ReadText() As String
On Error GoTo ErrHandle
    Dim objFSO As Object, ofile As Object
    Dim regEx As New RegExp
    Dim strTXT As String, inner As String
    Const ForReading = 1
      
    ' INITIALIZE OBJECTS
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set ofile = objFSO.OpenTextFile(ActiveWorkbook.Path & "\TEXT\Input.txt", ForReading)
    
    ' SET REGEX OBJECT
    With regEx
        .Global = True
        .MultiLine = True
        .IgnoreCase = False
        .Pattern = "[^A-Za-z]"
    End With
    
    ' OPEN FILE, READ LINES, CLOSE FILE
    strTXT = ""
    Do While ofile.AtEndofStream <> True
        inner = regEx.Replace(ofile.readline, " ")
                
        inner = Replace(inner, "      ", " ")
        inner = Trim(Replace(inner, " s ", "'s "))
        inner = Trim(Replace(inner, "o er", "o'er"))
                    
        If Trim(inner) <> "" Then
            inner = Replace(inner, "  ", " ")
            strTXT = strTXT & inner & vbNewLine
        End If
    Loop
    
    ReadText = strTXT
    ofile.Close
    
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
    
ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
    
End Function

Public Function WriteText()
On Error GoTo ErrHandle
    Dim objFSO As Object, ofile As Object
    Const fsoForWriting = 2
    Const fsoForAppend = 8
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    
    ' OPEN TEXT FILE
    Set ofile = objFSO.OpenTextFile(ActiveWorkbook.Path & "\TEXT\Output_XL.txt", fsoForWriting, True)
    
    ' WRITE TO FILE
    ofile.WriteLine ReadText
        
    ' CLOSE FILE
    ofile.Close
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
    
ErrHandle:
    MsgBox Err.Number & " - " & Err.Description, vbCritical
    Set ofile = Nothing
    Set objFSO = Nothing
    Exit Function
End Function
