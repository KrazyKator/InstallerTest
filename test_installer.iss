[Setup]
DefaultDirName={commonpf}Test Application
AppName=Test Application
AppVersion=1.0
DefaultGroupName=Test Application
OutputBaseFilename=test_installer
OutputDir=build
[Files]
Source: script.bat; DestDir: {app} 
[Icons]
Name: {group}\Run Script; Filename: {app}\script.bat; WorkingDir: {app}; AfterInstall: SetElevationBit('{group}\Run Script.lnk') 

[Code]
procedure SetElevationBit(Filename: string);
var
  Buffer: string;
  Stream: TStream;
begin
  Filename := ExpandConstant(Filename);
  Log('Setting elevation bit for ' + Filename);

  Stream := TFileStream.Create(FileName, fmOpenReadWrite);
  try
    Stream.Seek(21, soFromBeginning);
    SetLength(Buffer, 1);
    Stream.ReadBuffer(Buffer, 1);
    Buffer[1] := Chr(Ord(Buffer[1]) or $20);
    Stream.Seek(-1, soFromCurrent);
    Stream.WriteBuffer(Buffer, 1);
  finally
    Stream.Free;
  end;
end;
