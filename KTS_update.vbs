Set args = WScript.Arguments
 
'// you can get url via parameter like line below
'//Url = args.Item(0)
Dim oShell : Set oShell = CreateObject("WScript.Shell")
Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")

Dim KTSPathDest, Temp, UserPath, PlotPath, PMPPath, PlotStyles, Plotters, sTemp, iTemp1, Url

Const TemporaryFolder = 2

oShell.Run "taskkill /im acad.exe", 1, True

iTemp1 = 0

set service = GetObject ("winmgmts:")

Do while iTemp1 = 0
	iTemp1 = 1
	for each Process in Service.InstancesOf ("Win32_Process")
		If Process.Name = "acad.exe" then
			iTemp1 = 0
			Wscript.Sleep (500)
		End If
	next
loop

Wscript.Echo "AutoCad has been closed"
'LabPathSource = (Replace(Wscript.Arguments.Item(0),"\\","\"))
KTSPathDest = (Replace(Wscript.Arguments.Item(0),"\\","\"))
Temp = (Replace(Wscript.Arguments.Item(1),"\\","\"))

Wscript.Echo "Downloading update"
'//Download zip from GitHub
dim myPath, a, filename
dim xHttp: Set xHttp = createobject("MSXML2.ServerXMLHTTP.3.0")

Url = Wscript.Arguments.Item(7)

a=split(Url,"/")
filename=a(ubound(a))

myPath = fso.GetSpecialFolder(TemporaryFolder) & "/" & filename 

xHttp.Open "GET", Url, False
xHttp.Send

'Wscript.Echo "Download-Status: " ^& xHttp.Status ^& " " ^& xHttp.statusText
 
If xHttp.Status = 200 Then
    Dim objStream
    set objStream = CreateObject("ADODB.Stream")
    objStream.Type = 1 'adTypeBinary
    objStream.Open
    objStream.Write xHttp.responseBody
    objStream.SaveToFile myPath,2
    objStream.Close
    set objStream = Nothing
End If
set xHttp=Nothing

Wscript.Echo "Download complete"

'//Delete existing version

Wscript.Echo "Deleting existing KTS folder"
Const ReadOnly = 1
'Set fso = CreateObject(“Scripting.fsotemObject”)
Set objFolder = fso.GetFolder(KTSPathDest)
Set colFiles = objFolder.Files
For Each objFile in colFiles
    If objFile.Attributes AND ReadOnly Then
        objFile.Attributes = objFile.Attributes XOR ReadOnly
    End If
Next

If fso.FolderExists(KTSPathDest) Then  
    fso.DeleteFolder KTSPathDest, True
End If 

'//Extract new version
Wscript.Echo "Extracting new version"
'The location of the zip file.
ExtractTo=fso.GetSpecialFolder(TemporaryFolder) '"C:\Test\"
ZipFile=ExtractTo & "\" & filename '"C:\Test.Zip"

Set objFolder = fso.GetFolder(ExtractTo)
Set colFiles = objFolder.Files
For Each objFile in colFiles
    If objFile.Attributes AND ReadOnly Then
        objFile.Attributes = objFile.Attributes XOR ReadOnly
    End If
Next

ExtractFolder = ExtractTo & "\kitek_steel-master"

If fso.FolderExists(ExtractFolder) Then
   fso.DeleteFolder ExtractFolder, True
End If
'If NOT fso.FolderExists(ExtractTo) Then
'   fso.CreateFolder(ExtractTo)
'End If

'Extract the contants of the zip file.
set objShell = CreateObject("Shell.Application")
set FilesInZip = objShell.NameSpace(ZipFile).items
objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)
Set objShell = Nothing

CopySource=fso.GetSpecialFolder(TemporaryFolder) & "\kitek_steel-master"

Wscript.Echo "Copying new version"
If fso.FolderExists(CopySource) Then 
    fso.CopyFolder CopySource, KTSPathDest 
End If

Parrent = fso.GetParentFolderName(PlotPath) & "\"

'MsgBox(Parrent)

Wscript.Echo "Cleanup installation"

If fso.FolderExists(ExtractFolder) Then
   fso.DeleteFolder ExtractFolder, True
End If

fso.DeleteFile(fso.GetSpecialFolder(TemporaryFolder) & "\" & filename) 'Deletes the file throught the DeleteFile function

Set fso = Nothing

MsgBox("Update Successful")
