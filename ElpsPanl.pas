{$I DFS.INC}  { Standard defines for all Delphi Free Stuff components }

{------------------------------------------------------------------------------}
{ TdfsEllipsisPanel v1.20                                                      }
{------------------------------------------------------------------------------}
{ A panel that can shorten the caption text, replacing it with '...' when      }
{ it does not fit the available space.  Also provided is a generic function    }
{ that will "ellipsify" a string.  This function can be used to produce        }
{ other components like TdfsEllipsisPanel, such as TdfsEllipsisLabel.          }
{                                                                              }
{ Copyright 2000-2001, Brad Stowers.  All Rights Reserved.                     }
{ Remade by Valient Newman to comply with Delphi 2009 requirements             }
{                                                                              }
{ Copyright:                                                                   }
{ All Delphi Free Stuff (hereafter "DFS") source code is copyrighted by        }
{ Bradley D. Stowers (hereafter "author"), and shall remain the exclusive      }
{ property of the author.                                                      }
{                                                                              }
{ Distribution Rights:                                                         }
{ You are granted a non-exlusive, royalty-free right to produce and distribute }
{ compiled binary files (executables, DLLs, etc.) that are built with any of   }
{ the DFS source code unless specifically stated otherwise.                    }
{ You are further granted permission to redistribute any of the DFS source     }
{ code in source code form, provided that the original archive as found on the }
{ DFS web site (http://www.delphifreestuff.com) is distributed unmodified. For }
{ example, if you create a descendant of TDFSColorButton, you must include in  }
{ the distribution package the colorbtn.zip file in the exact form that you    }
{ downloaded it from http://www.delphifreestuff.com/mine/files/colorbtn.zip.   }
{                                                                              }
{ Restrictions:                                                                }
{ Without the express written consent of the author, you may not:              }
{   * Distribute modified versions of any DFS source code by itself. You must  }
{     include the original archive as you found it at the DFS site.            }
{   * Sell or lease any portion of DFS source code. You are, of course, free   }
{     to sell any of your own original code that works with, enhances, etc.    }
{     DFS source code.                                                         }
{   * Distribute DFS source code for profit.                                   }
{                                                                              }
{ Warranty:                                                                    }
{ There is absolutely no warranty of any kind whatsoever with any of the DFS   }
{ source code (hereafter "software"). The software is provided to you "AS-IS", }
{ and all risks and losses associated with it's use are assumed by you. In no  }
{ event shall the author of the softare, Bradley D. Stowers, be held           }
{ accountable for any damages or losses that may occur from use or misuse of   }
{ the software.                                                                }
{                                                                              }
{ Support:                                                                     }
{ Support is provided via the DFS Support Forum, which is a web-based message  }
{ system.  You can find it at http://www.delphifreestuff.com/discus/           }
{ All DFS source code is provided free of charge. As such, I can not guarantee }
{ any support whatsoever. While I do try to answer all questions that I        }
{ receive, and address all problems that are reported to me, you must          }
{ understand that I simply can not guarantee that this will always be so.      }
{                                                                              }
{ Clarifications:                                                              }
{ If you need any further information, please feel free to contact me directly.}
{ This agreement can be found online at my site in the "Miscellaneous" section.}
{------------------------------------------------------------------------------}
{ The latest version of my components are always available on the web at:      }
{   http://www.delphifreestuff.com/                                            }
{ See ElpsPanl.txt for notes, known issues, and revision history.              }
{------------------------------------------------------------------------------}
{ Date last modified:  June 27, 2001                                           }
{------------------------------------------------------------------------------}
{ Date last modified by Newman:  December 22, 2025                             }
{ Github Repository <https://github.com/valient-newman>                        }
{------------------------------------------------------------------------------}

unit ElpsPanl;

interface

uses
  {$IFDEF DFS_COMPILER_12_UP}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Menus;

const
  { This shuts up C++Builder 3 about the redefiniton being different. There
    seems to be no equivalent in C1.  Sorry. }
  {$IFDEF DFS_CPPB_3_UP}
  {$EXTERNALSYM DFS_COMPONENT_VERSION}
  {$ENDIF}
  DFS_COMPONENT_VERSION = 'TdfsEllipsisPanel v1.20';

type
  TAutoHintOption = (ahEnabled, ahWindowOnly, ahOnEllipsis);
  { ahEnabled    - Enable auto hint (set hint when caption too big.           }
  { ahWindowOnly - Don't generate applicatoin events, only the popup hint.    }
  {                Basically, it sticks an '|' on the end of the hint string. }
  { ahOnEllipsis - When Caption too big, Hint is set to Caption. When Caption }
  {                fits, Hint is set to last value assigned to it, either in  }
  {                IDE or code. For example, you set Hint = "My hint" and the }
  {                panel has to use "..." when it displayes the caption       }
  {                "Some Text String".  The hint would pop up as "Some Text   }
  {                String".  You then resize and the entire caption can be    }
  {                displayed in the panel.  The hint would then be "My hint". }

  TAutoHintOptions = set of TAutoHintOption;

const
  DEF_AUTOHINTOPTIONS = [ahEnabled, ahWindowOnly, ahOnEllipsis];

type
  TdfsEllipsisPanel = class(TCustomPanel)
  private
    FAutoHintOptions: TAutoHintOptions;
    FIsPath: boolean;
    FCaption: string;
    FSaveHint: string;

    procedure SetAutoHintOptions(Val: TAutoHintOptions);
    procedure SetIsPath(Val: boolean);
    procedure SetCaption(const Val: string);
    function GetCaption: string;

    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
  protected
    procedure UpdatePanelText;
    procedure UpdateHintText;
    procedure Loaded; override;
    function GetVersion: string;
    procedure SetVersion(const Val: string);
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF DFS_COMPILER_4_UP}
    property DockManager;
    {$ENDIF}
  published
    property Version: string
       read GetVersion
       write SetVersion
       stored FALSE;
    property AutoHintOptoins: TAutoHintOptions
       read FAutoHintOptions
       write SetAutoHintOptions
       default DEF_AUTOHINTOPTIONS;
    property IsPath: boolean
       read FIsPath
       write SetIsPath
       default FALSE;
    property Caption: string
       read GetCaption
       write SetCaption;

    { Publish inherited stuff }
    property Align;
    property Alignment;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property Font;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint default TRUE;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    {$IFDEF DFS_COMPILER_2_UP}
    property OnStartDrag;
    {$ENDIF}
    {$IFDEF DFS_COMPILER_3_UP}
    property FullRepaint;
    {$ENDIF}
    {$IFDEF DFS_COMPILER_4_UP}
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragKind;
    property ParentBiDiMode;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
    {$IFDEF DFS_COMPILER_5_UP}
    property OnContextPopup;
    {$ENDIF}
    {$IFDEF DFS_COMPILER_7_UP}
//    Make sure to add any new properties introduced in TPanel.
    {$ENDIF}
  end;

function EllipsifyText(AsPath: boolean; const Text: string;
                       const Canvas: TCanvas; MaxWidth: integer): string;


implementation


{$IFNDEF DFS_WIN32}
procedure SetLength(var s: string; NewLen: byte);
begin
  S[0] := chr(NewLen);
end;
{$ENDIF}

function EllipsifyText(AsPath: boolean; const Text: string;
                       const Canvas: TCanvas; MaxWidth: integer): string;
{$IFDEF DFS_WIN32}
var
   TempPChar: PChar;
   TempRect: TRect;
   Params: UINT;
begin
  // Alocate mem for PChar
  GetMem(TempPChar, Length(Text)+1);
  try
    // Copy Text into PChar
    TempPChar := StrPCopy(TempPChar, Text);
    // Create Rectangle to Store PChar
    TempRect := Rect(0,0, MaxWidth, High(Integer));
    // Set Params depending wether it's a path or not
    if AsPath then
      Params := DT_PATH_ELLIPSIS
    else
      Params := DT_END_ELLIPSIS;
    // Tell it to Modify the PChar, and do not draw to the canvas
    Params := Params + DT_MODIFYSTRING + DT_CALCRECT;
    // Ellipsify the string based on availble space to draw in
    DrawTextEx(Canvas.Handle, TempPChar, -1, TempRect, Params, nil);
    // Copy the modified PChar into the result
    Result := StrPas(TempPChar);
  finally
    // Free Memory from PChar
    FreeMem(TempPChar, Length(Text)+1);
  end;
{$ELSE}
  procedure CutFirstDirectory(var S: string);
  var
    Root: Boolean;
    P: Integer;
  begin
    if S = '' then exit;
    if S = '\' then
      S := ''
    else begin
      if S[1] = '\' then begin
        Root := True;
        Delete(S, 1, 1);
      end else
        Root := False;
      if S[1] = '.' then
        Delete(S, 1, 4);
      P := Pos('\',S);
      if P <> 0 then begin
        Delete(S, 1, P);
        S := '...\' + S;
      end else
        S := '';
      if Root then
        S := '\' + S;
    end;
  end;

  function MinimizeName(const Filename: string; const Canvas: TCanvas;
                        MaxLen: Integer): string;
  var
    Drive: string;
    Dir: string;
    Name: string;
  begin
    Result := FileName;
    Dir := ExtractFilePath(Result);
    Name := ExtractFileName(Result);

    if (Length(Dir) >= 2) and (Dir[2] = ':') then begin
      Drive := Copy(Dir, 1, 2);
      Delete(Dir, 1, 2);
    end else
      Drive := '';
    while ((Dir <> '') or (Drive <> '')) and (Canvas.TextWidth(Result) > MaxLen) do begin
      if Dir = '\...\' then begin
        Drive := '';
        Dir := '...\';
      end else if Dir = '' then
        Drive := ''
      else
        CutFirstDirectory(Dir);
      Result := Drive + Dir + Name;
    end;
  end;
var
  Temp: string;
  AvgChar: integer;
  TLen,
  Index: integer;
  Metrics: TTextMetric;
begin
  try
    if AsPath then begin
      Result := MinimizeName(Text, Canvas, MaxWidth);
    end else begin
      Temp := Text;
      if (Temp <> '') and (Canvas.TextWidth(Temp) > MaxWidth) then begin
        GetTextMetrics(Canvas.Handle, Metrics);
        AvgChar := Metrics.tmAveCharWidth;
        if (AvgChar * 3) < MaxWidth then begin
          Index := (MaxWidth div AvgChar) - 1;
          Temp := Copy(Text, 1, Index);
          if Canvas.TextWidth(Temp + '...') > MaxWidth then begin
            repeat
              dec(Index);
              SetLength(Temp, Index);
            until (Canvas.TextWidth(Temp + '...') < MaxWidth) or (Index < 1);
            { delete chars }
          end else begin
            TLen := Length(Text);
            repeat
              inc(Index);
              Temp := Copy(Text, 1, Index);
            until (Canvas.TextWidth(Temp + '...') > MaxWidth) or (Index >= TLen);
            SetLength(Temp, Index-1);
          end;
          Temp := Temp + '...';
        end else
          Temp := '.';
      end;
      Result := Temp;
    end;
  except
    Result := '';
  end;
{$ENDIF}
end;


constructor TdfsEllipsisPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoHintOptions := DEF_AUTOHINTOPTIONS;
  ShowHint := TRUE;
  FIsPath := FALSE;
  FCaption := '';
  FSaveHint := '';
end;

procedure TdfsEllipsisPanel.Loaded;
begin
  inherited Loaded;
  FSaveHint := Hint;
end;

procedure TdfsEllipsisPanel.UpdatePanelText;
begin
  if HandleAllocated then begin
    { Make sure the right font has been selected. }
    Canvas.Font.Assign(Font);
    inherited Caption := EllipsifyText(FIsPath, FCaption, Canvas,
       ClientWidth-(BevelWidth*2)-BorderWidth*2);
    UpdateHintText;
  end;
end;

procedure TdfsEllipsisPanel.UpdateHintText;
  function LastChar(const Str: string): char;
  begin
    if Length(Str) > 0 then
      Result := Str[Length(Str)]
    else
      Result := #0;
  end;
begin
  if ahEnabled in FAutoHintOptions then begin
    if ahOnEllipsis in FAutoHintOptions then begin
      if (Length(inherited Caption) > 2) and
         (Copy(inherited Caption, Length(inherited Caption)-2, 3) = '...') then
        Hint := FCaption
      else
        Hint := FSaveHint;
    end else
      Hint := FCaption;

{.$DEFINE WANT-TO-SEE-A-DELPHI-2-BUG}
{$IFDEF WANT-TO-SEE-A-DELPHI-2-BUG}
    if ahWindowOnly in FAutoHintOptions then begin
(* This code causes internal error c3254!  It is the second part of the "if" statement,
   but only if there is some code inside the begin...end.
                                vvvvvvvvvvvvvvvvvvvvvvvvvvv               *)
      if (Length(Hint) > 0) and (Hint[Length(Hint)] <> '|') then
        Hint := Hint + '|';
    end else begin
      if (Length(Hint) > 0) and (Hint[Length(Hint)] = '|') then
        Hint := Copy(Hint, 1, Length(Hint)-1);
    end;
{$ELSE}
    if ahWindowOnly in FAutoHintOptions then begin
      if LastChar(Hint) <> '|' then
        Hint := Hint + '|';
    end else begin
      if LastChar(Hint) = '|' then
        Hint := Copy(Hint, 1, Length(Hint)-1);
    end;
{$ENDIF}

  end else begin
    Hint := FSaveHint;
  end;
end; { This is where you will see the C3254 error message.  Caused on line 290 }

procedure TdfsEllipsisPanel.SetAutoHintOptions(Val: TAutoHintOptions);
begin
  if FAutoHintOptions <> Val then begin
    FAutoHintOptions := Val;
    UpdateHintText;
  end;
end;

procedure TdfsEllipsisPanel.SetIsPath(Val: boolean);
begin
  if Val = FIsPath then exit;
  FIsPath := Val;
  UpdatePanelText;
end;

procedure TdfsEllipsisPanel.SetCaption(const Val: string);
begin
  if Val = FCaption then exit;
  FCaption := Val;
  UpdatePanelText;
end;

function TdfsEllipsisPanel.GetCaption: string;
begin
  Result := FCaption;
end;

procedure TdfsEllipsisPanel.WMSize(var Msg: TWMSize);
begin
  inherited;
  UpdatePanelText;
end;

procedure TdfsEllipsisPanel.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Refresh;
  UpdatePanelText;
end;

function TdfsEllipsisPanel.GetVersion: string;
begin
  Result := DFS_COMPONENT_VERSION;
end;

procedure TdfsEllipsisPanel.SetVersion(const Val: string);
begin
  { empty write method, just needed to get it to show up in Object Inspector }
end;

end.

