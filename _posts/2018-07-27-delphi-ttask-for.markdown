---
layout: post
title:  "[delphi] TTask 와 for문"
date:   2018-06-11 00:00:00
categories: delphi
published: true
---

0. TOC
{:toc}


##### TTask
  TTask는 매개 변수 없이 프로시저 함수만 허용하지만 실제 개발에선 매개 변수를 전달해야 할 경우가 있음.
  for문으로 테스트


##### 일반적인 사용법
{% highlight ruby %}
procedure TForm5.Button1Click(Sender: TObject);
var
  tasks: TArray<ITask>;
  i: Integer;
begin
  SetLength(tasks, 3);
  for i := 0 to Length(tasks) -1 do
  begin
    tasks[i] := TTask.Run(
      procedure
      begin
        OutputdebugString(PChar(IntToStr(i)));
      end);
  end;
  TTask.WaitForAll(tasks);
end;

Result
------
3
3
3
------
{% endhighlight %}


##### 매개 변수 전달 1
{% highlight ruby %}
procedure TForm5.Button1Click(Sender: TObject);
var
  tasks: TArray<ITask>;
  procInt: TProc<Integer>;
  i: Integer;
begin
  SetLength(tasks, 3);
  for i := 0 to Length(tasks) -1 do
  begin
    procInt := procedure (i: Integer)
      begin
        tasks[i] := TTask.Run(
          procedure
          begin
            OutputdebugString(PChar(IntToStr(i)));
          end);
      end;
    procInt(i)
  end;
  TTask.WaitForAll(tasks);
end;

Result
------
0
1
2
------
{% endhighlight %}


##### 매개 변수 전달 2
{% highlight ruby %}
unit Unit8;

interface

uses
  System.Threading, System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm8 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TTaskWork = class
 private
    m_nInt: Integer;
    procedure Execute;
  public
    constructor Create(nInt: Integer);
    function Start: ITask;
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
var
  list: TObjectList<TTaskWork>;
  tasks: TArray<ITask>;
  i: Integer;
begin
  list := TObjectList<TTaskWork>.Create;
  for i := 0 to 2 do
    list.Add(TTaskWork.Create(i));

  SetLength(tasks, list.Count);
  for i := 0 to list.Count - 1 do
    tasks[i] := list[i].Start;

  TTask.WaitForAll(tasks);
  list.Free;
end;

{ TTaskWork }

constructor TTaskWork.Create(nInt: Integer);
begin
  m_nInt := nInt;
end;

procedure TTaskWork.Execute;
begin
  OutputdebugString(PChar(IntToStr(m_nInt)));
end;

function TTaskWork.Start: ITask;
begin
  Result := TTask.Run(Execute);
end;

end.

Result
------
0
1
2
------
{% endhighlight %}


##### 매개 변수 전달 3
{% highlight ruby %}
unit Unit6;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Generics.Collections;

procedure InitTasks;
procedure AddTask(nInt: Integer);
procedure RunTasks;
procedure WaitTask;

implementation

uses
  System.Threading;

type
  TTaskWork = class
 private
    m_nInt: Integer;
    procedure Execute;
  public
    constructor Create(nInt: Integer);
    function Start: ITask;
  end;

var
  m_Objectlist: TObjectList<TTaskWork>;
  m_Tasks: TArray<ITask>;

procedure InitTasks;
var
  i: Integer;
begin
  for i := m_Objectlist.Count -1 downto 0 do
    m_Objectlist.Items[i].Free;

  m_Objectlist.Clear;
end;

procedure AddTask(nInt: Integer);
begin
  m_Objectlist.Add(TTaskWork.Create(nInt));
end;

procedure RunTasks;
var
  i: Integer;
begin
  SetLength(m_Tasks, m_Objectlist.Count);
  for i := 0 to m_Objectlist.Count -1 do
    m_Tasks[i] := m_Objectlist[i].Start;
end;

procedure WaitTask;
begin
  TTask.WaitForAll(m_Tasks);
end;

{ TTaskWork }

constructor TTaskWork.Create(nInt: Integer);
begin
  m_nInt := nInt;
end;

procedure TTaskWork.Execute;
begin
  OutputdebugString(PChar(IntToStr(m_nInt)));
end;

function TTaskWork.Start: ITask;
begin
  Result := TTask.Run(Execute);
end;

initialization
  m_Objectlist := TObjectList<TTaskWork>.Create;

finalization
  m_Objectlist.Free;

end.
{% endhighlight %}

{% highlight ruby %}
unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses
  Unit6;

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  InitTasks;
  for i := 0 to 2 do
    AddTask(i);
  RunTasks;
  WaitTask;
end;

end.

Result
------
0
1
2
------
{% endhighlight %}