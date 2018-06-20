---
layout: post
title:  "[delphi] TWebbrowser 내 javascript 에서 delphi 함수 호출"
date:   2018-06-11 00:00:00
categories: delphi
published: true
---

0. TOC
{:toc}

##### 자바스크립트에서 델파이 함수 호출
 - TWebbrowser를 활용하다보면 델파이 함수를 웹페이지에서 호출해야할 필요가 생긴다.
 - [파이어몽키에서는 컴포넌트 메소드를 통해 이벤트를 가져올 수 있어보인다.](http://blog.hjf.pe.kr/378)
 - [검색하면 델파이를 통해 자바스크립트를 사용하는 방법 위주로 나오는 듯하다.](https://www.delmadang.com/community/bbs_view.asp?bbsNo=21&bbsCat=0&st=S&keyword=%uC790%uBC14%uC2A4%uD06C%uB9BD%uD2B8&indx=449443&keyword1=%C0%DA%B9%D9%BD%BA%C5%A9%B8%B3%C6%AE&page=1%20%20%EA%B7%B8%EB%A6%AC%EA%B3%A0%20%EC%A7%88%EB%8B%B5%EB%9E%80%EC%9D%98%20%EC%98%81%ED%9B%88%EB%8B%98%EC%9D%98%20%EB%8B%B5%EB%B3%80%20%EC%B0%B8%EA%B3%A0%ED%95%98%EC%84%B8%EC%9A%94.%20https://www.delmadang.com/community/bbs_view.asp?bbsNo=17&bbsCat=0&st=C&keyword=twebbrowser&indx=440673&keyword1=twebbrowser&page=2)
 - [정석(?)은 com과 같이 외부객체를 활용하는 방법으로 보이는데...](http://delphidabbler.com/articles?article=22&part=4)
 - 살펴보니 TWebbrowser 상태 프로퍼티를 활용하는 꼼수적인 방법이 있다. 
 - 방법은 자바스크립트 이벤트를 통해 상태 텍스트를 변경, TWebbrowser에선 상태 텍스트의 변경 이벤트를 확인 후 변경된 상태 텍스트을 활용하여 원하는 델파이 핸들 내 함수명과 일치된 함수를 실행한다.


##### code
- index.html
{% highlight ruby %}
 <!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <script language="javascript">
        function DelMessage() {
            window.status = 'delFunc_Message';
            window.status = '';
        }

        function DelForm() {
            window.status = 'delFunc_Form';
            window.status = '';
        }
        function DelMainMessage() {
            window.status = 'delFunc_MainMessage';
            window.status = '';
        }

        function DelMainForm() {
            window.status = 'delFunc_MainForm';
            window.status = '';
        }
    </script>
</head>

<body>
    <input type="button" value="나와라 델파이 TCallFunc 메시지" onclick='DelMessage()'>
    <input type="button" value="나와라 델파이 TCallFunc 폼" onclick='DelForm()'>
    <input type="button" value="나와라 델파이 메인 메시지" onclick='DelMainMessage()'>
    <input type="button" value="나와라 델파이 메인 폼" onclick='DelMainForm()'>
</body>
</html>
{% endhighlight %}

- Main.pas
{% highlight ruby %}
unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFMain = class(TForm)
    pnl: TPanel;
    btnMsg: TButton;
    btnForm: TButton;
    mmoLog: TMemo;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    wbs: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure wbsStatusTextChange(ASender: TObject; const Text: WideString);
    procedure btnFormClick(Sender: TObject);
    procedure btnMsgClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddLog(s: String);
  public
    { Public declarations }
  published
    procedure delFunc_MainMessage;
    procedure delFunc_MainForm;
  end;

var
  FMain: TFMain;

implementation

uses
  UCommon, UCallFunc;

{$R *.dfm}

procedure TFMain.AddLog(s: String);
begin
  mmoLog.Lines.Add(s);
end;

procedure TFMain.btnFormClick(Sender: TObject);
var
  f: TForm;
begin
  f := TForm.Create(nil);
  f.Caption := '메인 폼';
  f.ShowModal;
  f.Free;
end;

procedure TFMain.btnMsgClick(Sender: TObject);
begin
  ShowMessage('메인 메시지');
end;

procedure TFMain.delFunc_MainForm;
begin
  btnForm.Click;
end;

procedure TFMain.delFunc_MainMessage;
begin
  btnMsg.Click;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  wbs.Navigate2(ExtractFilePath(Application.ExeName) + 'index.html');
end;

procedure TFMain.wbsStatusTextChange(ASender: TObject; const Text: WideString);
const
  CST_DEL_FUNC = 'delFunc_';
var
  sFuncName: String;
begin
  sFuncName := Text;
  if Pos(CST_DEL_FUNC, sFuncName) = 0 then Exit;

  AddLog('Web Status: ' + String(Text));
  SetTimeOut( procedure
    begin
      // 사용할 함수가 있는 클래스를 넘겨줘야한다.
      CallMethod(g_CallFunc, sFuncName)
//      CallMethod(Self, sFuncName)
    end, 1);
end;

end.
{% endhighlight %}

- UCallFunc.pas
{% highlight ruby %}
unit UCallFunc;

interface

uses
  Vcl.Dialogs, Vcl.Forms;

{$M+}
type
  TCallFunc = class
  private
  public
  published
    procedure delFunc_Message;
    procedure delFunc_Form;
  end;
{$M-}

var
  g_CallFunc: TCallFunc;

implementation

{ TCallFunc }

procedure TCallFunc.delFunc_Form;
var
  f: TForm;
begin
  f := TForm.Create(nil);
  f.Caption := 'TCallFunc 폼';
  f.ShowModal;
  f.Free;
end;

procedure TCallFunc.delFunc_Message;
begin
  ShowMessage('TCallFunc 메시지 테스트');
end;

initialization
  g_CallFunc := TCallFunc.Create;

finalization
  g_CallFunc.Free;

end.
{% endhighlight %}

- UCommon.pas
{% highlight ruby %}
unit UCommon;

interface

uses
  System.SysUtils, System.Classes, System.Threading, System.Rtti;

procedure SetTimeOut(proc: TProc; nInterval: Integer = 100);

// 함수 이름으로 함수 호출
// 취향것 사용
procedure CallMethod(obj: TObject; AMethodName: string); overload;
function CallMethod(obj: TObject; AMethodName: string; AParameters: TArray<TValue>): TValue; overload;


implementation

procedure SetTimeOut(proc: TProc; nInterval: Integer = 100);
begin
  TThread.CreateAnonymousThread( procedure
    begin
    Sleep(nInterval);
  	// 내부 코드
    TThread.Synchronize( TThread.CurrentThread, procedure
      begin
    		// GUI 코드
        proc
      end);
    end).Start;
end;

procedure CallMethod(obj: TObject; AMethodName: string);
type
  TExecute = procedure of object;
var
  e: TExecute;
begin
  TMethod(e).Data := obj;
  TMethod(e).Code := obj.MethodAddress(AMethodName);
  if Assigned(e) then e;
end;

function CallMethod(obj: TObject; AMethodName: string; AParameters: TArray<TValue>): TValue;
{
// IF문을 사용하는 방식
begin
  if AMethodName = 'callDelphiMethodFromJS' then
    callDelphiMethodFromJS
  else if AMethodName = 'callDelphiMethodFromJSWithParam' then
    callDelphiMethodFromJSWithParam(AParameters[0].AsString, AParameters[1].AsString);
end;
}
// RTTI로 메소드이름으로 메소드 호출하는 방식(published, public 으로 메소드가 선언되야함)
var
  RttiCtx: TRttiContext;
  RttiTyp: TRttiType;
  RttiMtd: TRttiMethod;
begin
  RttiCtx := TRttiContext.Create;
  RttiTyp := RttiCtx.GetType(obj.ClassInfo);
  RttiMtd := nil;
  if Assigned(RttiTyp) then
  begin
    RttiMtd := RttiTyp.GetMethod(AMethodName);
    if Assigned(RttiMtd) then
      Result := RttiMtd.Invoke(obj, AParameters);
  end;
  RttiMtd.Free;
  RttiTyp.Free;
  RttiCtx.Free;
end;

end.
{% endhighlight %}

##### source
[CallDelphiFunctionFromJavascript](https://github.com/ggi88/SampleProject/tree/master/Delphi/XE8/CallDelFuncFromJS)