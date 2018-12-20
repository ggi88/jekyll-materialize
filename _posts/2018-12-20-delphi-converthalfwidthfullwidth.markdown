---
layout: post
title:  "[delphi] 반각 전각 변환"
date:   2018-12-20 00:00:00
categories: delphi
published: true
---

0. TOC
{:toc}


##### 반각과 전각
  나무위키 설명: https://namu.wiki/w/%EC%A0%84%EA%B0%81%EA%B3%BC%20%EB%B0%98%EA%B0%81?from=%EB%B0%98%EA%B0%81


##### 사용법1
{% highlight ruby %}
function ToFullWidth(Char: Char): Char;
var
  c: Integer;
  i: Integer;
begin
  c := Ord(Char);
  if (c >= $21) and (c <= $7E) then // 영문 알파벳 이거나 특수문자
    c := c + $FEE0
  else if (c = $20) then // 공백
    c := $3000;
  Result := Chr(c);
end;

function ToHalfWidth(Char: Char): Char;
var
  c: Integer;
  i: Integer;
begin
  c := Ord(Char);
  if (c >= Ord('！')) and (c <= Ord('～')) then
    c := c - $FEE0
  else if (c = Ord('　')) then
    c := $20;
  Result := Chr(c);
end;
{% endhighlight %}


##### 사용법2
{% highlight ruby %}
{ **
* Conversion 종류
* 상수                          의미
* LCMAP_BYTEREV	Windows NT 만 : 바이트 순서를 반전합니다. 예를 들어 0x3450과 0x4822을 전달하면 결과는 0x5034과 0x2248입니다.
* CMAP_FULLWIDTH              :	전각 문자합니다 (적용되는 경우).
* CMAP_HALFWIDTH              :	반자합니다 (적용되는 경우).
* CMAP_HIRAGANA               :	히라가나합니다.
* CMAP_KATAKANA               :	카타카나합니다.
* CMAP_LINGUISTIC_CASING      :	대소 문자 구분 파일 시스템의 규칙 (기본값) 대신 언어의 규칙을 사용합니다. LCMAP_LOWERCASE 또는 LCMAP_UPPERCASE와 만 함께 사용할 수 있습니다.
* CMAP_LOWERCASE              :	소문자를 사용합니다.
* CMAP_SIMPLIFIED_CHINESE     :	중국어 간체를 번체로 매핑합니다.
* CMAP_SORTKEY                :	정규화 된 와이드 문자 정렬 키를 만듭니다.
* CMAP_TRADITIONAL_CHINESE    :	중국어 번체를 간체로 매핑합니다.
* CMAP_UPPERCASE              :	대문자를 사용합니다.
* ORM_IGNORECASE              :	대소 문자를 구별하지 않습니다.
* ORM_IGNOREKANATYPE          :	히라가나와 가타카나를 구분하지 않습니다. 히라가나와 가타카나를 동일한 것으로 간주합니다.
* ORM_IGNORENONSPACE          :	보내없이 문자를 무시합니다. 이 플래그를 설정하면 일본어 악센트 문자도 삭제됩니다.
* ORM_IGNORESYMBOLS           :	기호를 무시합니다.
* ORM_IGNOREWIDTH             :	싱글 바이트 문자와 2 바이트 같은 문자를 구분하지 않습니다.
* ORT_STRINGORT               :	구분 기호와 같은 것으로 취급합니다.
*
* 참조
* http://mrxray.on.coocan.jp/Delphi/plSamples/881_ToHankakuKana.htm#04
* https://msdn.microsoft.com/ja-jp/library/cc448052.aspx
}
function StrConv(const sText: String; Conversion: DWORD): String; overload;
var
  nSize: Integer;
begin
  nSize := LCMapString(LOCALE_SYSTEM_DEFAULT,
                       Conversion,
                       PChar(sText),
                       Length(sText),
                       nil,
                       0);
  SetLength(Result, nSize);
  nSize := LCMapString(LOCALE_SYSTEM_DEFAULT,
                       Conversion,
                       PChar(sText),
                       Length(sText),
                       PChar(Result),
                       nSize);
  if nSize <= 0 then
    Result := sText
  else
    SetLength(Result, nSize);
end;

// 전각
Result := StrConv(sText, LCMAP_FULLWIDTH);

// 반각
Result := StrConv(Char, LCMAP_FULLWIDTH);
{% endhighlight %}
