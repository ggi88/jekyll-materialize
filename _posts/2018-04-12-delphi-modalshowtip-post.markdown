---
layout: post
title:  "[delphi] 모달 창 띄울 시 배경 효과"
date:   2018-04-12 00:00:00
categories: delphi
published: true
---
- 모달 창을 띄울 때 BG변화를 줄 수 있는 예
- 모달 창을 띄우기 전 후에 실행되는  "Application.OnModalBegin", "Application.OnModalEnd" 이벤트 활용
- Delphi XE8

##### code
main.pas

{% highlight ruby %}
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.StdCtrls;

type
  TFMain = class(TForm)
    btnModal: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnModalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure OnEventsModalBegin(Sender: TObject);
    procedure OnEventsModalEnd(Sender: TObject);
  end;

var
  FMain: TFMain;

implementation

uses
  Screen;

{$R *.dfm}

procedure TFMain.OnEventsModalBegin(Sender: TObject);
begin
  ScreenBegin(Self);
end;

procedure TFMain.OnEventsModalEnd(Sender: TObject);
begin
  ScreenEnd;
end;

procedure TFMain.btnModalClick(Sender: TObject);
var
  f: TForm;
begin
  f := TForm.Create(Self);
  f.ShowModal;
  f.Free;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  Application.OnModalBegin := OnEventsModalBegin;
  Application.OnModalEnd := OnEventsModalEnd;
end;

end.

{% endhighlight %}  

Screen.pas
- FScreen.BorderIcons = [bsNone]
- FScreen.AlphaBlend = True
- FScreen.AlphaBlendValue = 150

{% highlight ruby %}
unit Screen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFScreen = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ScreenBegin(f: TForm);
procedure ScreenEnd;

implementation

{$R *.dfm}

var
  FScreen: TFScreen;

procedure ScreenBegin(f: TForm);
begin
  if FScreen = nil then
    FScreen := TFScreen.Create(nil);

  FScreen.Top := f.Top;
  FScreen.Left := f.Left;
  FScreen.Height := f.Height;
  FScreen.Width := f.Width;
  FScreen.Show;
end;

procedure ScreenEnd;
begin
  FScreen.Hide;
end;

initialization

finalization
  FScreen.Free;
  FScreen := nil;

end.

{% endhighlight %}  
