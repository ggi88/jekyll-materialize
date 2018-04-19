---
layout: post
title:  "[delphi] 비트 플래그(Bit Flags)"
date:   2018-04-19 00:00:00
categories: delphi
published: true
---

##### 비트 플래그(Bit Flags)
- 비트 수준 조작은 프로그램의 공간을 절약하기 위해 사용
- 아래 코드와는 다르게 열거형과 집합을 활용 할 수도 있음

##### code
{% highlight ruby %}
program Project1;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  uFunc in 'uFunc.pas';

var
  n: Integer;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Writeln( '[비트 연산 플래그 테스트]' + #13#10
           + '[종류 Type1 = 1, Type1 = 2, Type1 = 3]' + #13#10 );
    while True do
    begin
      Writeln('종료 0');
      Writeln('플래그 입력 1~7: ');
      Readln(n);

      if n = 0 then Exit;
      if not( n in [1..7]) then Continue;

      Writeln('');
      PrintType(n);
      Writeln('');
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

{% endhighlight %}

{% highlight ruby %}
unit uFunc;

interface

const
  btType1 = 1;
  btType2 = 2;
  btType3 = 3;


procedure PrintType(n: Integer);

implementation

function IsContain(n1, n2: Integer): Boolean;
begin
  Result := n1 and n2 = n2;
end;

function IsType1(n: Integer): Boolean;
begin
  Result := IsContain(n, btType1);
end;

function IsType2(n: Integer): Boolean;
begin
  Result := IsContain(n, btType2);
end;

function IsType3(n: Integer): Boolean;
begin
  Result := IsContain(n, btType3);
end;

procedure PrintType(n: Integer);
begin
  if IsType1(n) then Writeln('Type1 ON') else Writeln('Type1 OFF');
  if IsType2(n) then Writeln('Type2 ON') else Writeln('Type2 OFF');
  if IsType3(n) then Writeln('Type3 ON') else Writeln('Type3 OFF');
end;

end.
{% endhighlight %}