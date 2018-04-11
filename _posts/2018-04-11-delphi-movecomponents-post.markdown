---
layout: post
title:  "[delphi] 컴포넌트 이동하기(Moving components)"
date:   2018-04-11 00:00:00
categories: delphi
published: true
---
##### 폼 안에 컴포넌트 움직이기
- 자유도 높은 화면 구성이 필요해서 데모를 만듬
- components의 parent와 control index 를 활용함
- Delphi 2006 에서 작성

##### code
{% highlight ruby %}
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, sPanel, StdCtrls, sButton, Math;

type
  TForm6 = class(TForm)
    fnlBG: TFlowPanel;
    pnlMenu: TsPanel;
    btnEdit: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure OnFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OnFormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnEditClick(Sender: TObject);
  private
    { Private declarations }
    bEditMode, bItemSelected: Boolean;
    NewPos, OldPos: TPoint;
    arrForms: array of TForm;
    arrButtons: array of TButton;
  public
    { Public declarations }
  end;

const
  MAX_FORM = 10;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  // Init
  bEditMode := False;
  bItemSelected := False;
  SetLength(arrForms, MAX_FORM);
  SetLength(arrButtons, MAX_FORM);
  
  for i := 0 to MAX_FORM - 1 do
  begin
    // Set Form
    arrForms[i] := TForm.Create(Self);
    arrForms[i].BorderStyle := bsNone;
    Randomize;
    arrForms[i].Color := RGB(Random(255), Random(255), Random(255));
    arrForms[i].Visible := false;
    arrForms[i].AlignWithMargins := True;
    arrForms[i].Caption := IntToStr(i);
    arrForms[i].Parent := fnlBG;
    arrForms[i].Height := 100;

    case i of
      0, 6:
        arrForms[i].Width := 800;
      1..4:
        arrForms[i].Width := 400;
      else
        arrForms[i].Width := 200;
    end;

    // Set Button
    arrButtons[i] := TButton.Create(Self);
    arrButtons[i].Caption := 'Move';
    arrButtons[i].Visible := False;
    arrButtons[i].Parent := arrForms[i];

    arrButtons[i].OnMouseDown := OnFormMouseDown;
    arrButtons[i].OnMouseMove := OnFormMouseMove;
    arrButtons[i].OnMouseUp := OnFormMouseUp;
  end;

  // show
  for i := 0 to MAX_FORM - 1 do
  begin
    arrForms[i].Visible := True;
    arrButtons[i].Visible := True;
  end;
end;

procedure TForm6.OnFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  bItemSelected := True;
  if (Button = mbLeft) then
  begin
    (Sender as TButton).Parent.Parent := Self;
    SetCapture((Sender as TButton).Handle);
    GetCursorPos(OldPos);
  end;
end;

procedure TForm6.OnFormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if not bItemSelected then
    Exit;
  GetCursorPos(NewPos);
  (Sender as TButton).Parent.Left := (Sender as TButton).Parent.Left - OldPos.X + NewPos.X;
  (Sender as TButton).Parent.Top := (Sender as TButton).Parent.Top - OldPos.Y + NewPos.Y;
  OldPos := NewPos;
end;

procedure TForm6.OnFormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TmpPos: TPoint;
  AHWN: HWND;
  nIdx: Integer;
begin
  if not bItemSelected then
    Exit;

  (Sender as TButton).Parent.Parent := fnlBG;
  GetCursorPos(TmpPos);
  AHWN := WindowFromPoint(TmpPos);

  if FindControl(AHWN) is TForm then
  begin
    nIdx := fnlBG.GetControlIndex(FindControl(AHWN) as TForm);
    fnlBG.SetControlIndex((Sender as TButton).Parent, nIdx);
    ReleaseCapture;
  end;
  bItemSelected := False;
end;

procedure TForm6.btnEditClick(Sender: TObject);
var
  i: Integer;
begin
  bEditMode := not bEditMode;

  for i := 0 to MAX_FORM - 1 do
  begin
    if bEditMode then
      arrForms[i].BorderStyle := bsToolWindow
    else
      arrForms[i].BorderStyle := bsNone;
  end;
end;

end.

{% endhighlight %}  


##### file link
- [MoveComponent](https://drive.google.com/file/d/1SquBp3JLa-ru7HvgoyTME5n7XtklCDLy/view?usp=sharing)

