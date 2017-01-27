


Set args = WScript.Arguments
 
'// you can get url via parameter like line below
'//Url = args.Item(0)
 
dim Url, myPath, a, filename
dim xHttp: Set xHttp = createobject("MSXML2.ServerXMLHTTP.3.0")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
Const TemporaryFolder = 2


Url = Wscript.Arguments.Item(0)


a=split(Url,"/")
filename=a(ubound(a))



Set objFSO = CreateObject( "Scripting.FileSystemObject" )

myPath = objFSO.GetSpecialFolder(TemporaryFolder) & "/" & filename 

xHttp.Open "GET", Url, False
xHttp.Send
 
with bStrm
    .type = 1 '//binary
    .open
    .write xHttp.responseBody
    .savetofile myPath, 2 '//overwrite
end with