---
layout: post
title:  "[delphi] 타입 변환"
date:   2018-04-03 00:00:00
categories: delphi
published: true
---
타입 변환

- AnsiString to Bytes(array of byte)

- Bytes(array of byte) to AnsiString

- Hex String to Bytes(array of byte)

- Bytes(array of byte) to Hex String

{% highlight ruby %}

function ToStrByte(ansi: AnsiString): TBytes;
begin
  SetLength(Result, Length(ansi));
  Move(ansi[1], Result[0], Length(ansi));
end;

function ToByteStr(b: TBytes): AnsiString;
begin
  SetLength(Result, Length(b));
  Move(b[0], Result[1], Length(b));
end;

function ToByteHex(b: TBytes): AnsiString;
var i: integer;
begin
  Result := '';
  for i in b do Result := Result + IntToHex(i, 2);
end;

function ToHexByte(hex: AnsiString): TBytes;
var i: Integer;
begin
  SetLength(Result, Length(hex) div 2);
  for i:= 0 to Length(Result) - 1 do
    Result[i] := StrToInt('$' + Copy(hex, (i*2) + 1, 2));
end;

{% endhighlight %}

- 예)

{% highlight ruby %}

procedure TForm1.FormCreate(Sender: TObject);
var
  s1, s2, sTemp: String;
  b1, b2: TBytes;
begin
  sTemp := '테스트';
  b1 := ToStrByte(sTemp);
  s1 := ToByteHex(b1);
  ShowMessage(s1);

  b2 := ToHexByte(s1);
  s2 := ToByteStr(b2);
  ShowMessage(s2);
end;

{% endhighlight %}