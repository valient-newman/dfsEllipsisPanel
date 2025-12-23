{$I DFS.INC}

unit ElPnlReg;

interface

{$IFDEF DFS_WIN32}
  {$R ElpsPanl.res}
{$ELSE}
  {$R ElpsPanl.r16}
{$ENDIF}

procedure Register;

implementation

uses
  {$IFDEF DFS_NO_DSGNINTF}
  DesignIntf,
  DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF}
  ElpsPanl, DFSAbout, Classes;


procedure Register;
begin
  RegisterComponents('DFS', [TdfsEllipsisPanel]);
  RegisterPropertyEditor(TypeInfo(string), TdfsEllipsisPanel, 'Version',
     TDFSVersionProperty);
end;


end.
