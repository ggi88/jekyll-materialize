---
layout: post
title:  "[delphi] pcap Header 살펴보기"
date:   2018-04-05 00:00:00
categories: delphi
published: true
---

##### Data Type
{% highlight ruby %}
┌───────────────────┐
│GLib     │C              │Delphi    │
├───────────────────┤
│guint32  │unsigned int   │LongWord  │
│guint16  │unsigned short │Word      │
│gint32   │signed int     │Integer   │
│         │unsigned char  │Byte      │
│         │unsigned int16 │word      │
┖───────────────────┘
{% endhighlight %}  


##### GLOBAL HEADER 구조체
{% highlight ruby %}
type
  TGLOBAL_HEADER = record
    magic_number: LongWord;
    version_major: Word;
    version_minor: Word;
    thiszone: Integer;
    sigfigs: LongWord;
    snaplen: LongWord;
    network: LongWord;
  end;
  PGLOBAL_HEADER = ^TGLOBAL_HEADER;
{% endhighlight %}  


##### PACKET HEADER 구조체
{% highlight ruby %}
type
  TPACKET_HEADER = record
    ts_sec: LongWord;
    ts_usec: LongWord;
    incl_len: LongWord;
    orig_len: LongWord;
  end;
  PPACKET_HEADER = ^TPACKET_HEADER;
{% endhighlight %}  


##### PACKET DATA
- 특정 바이트 정렬없이 incl_len 바이트의 데이터 blob로서 패킷 헤더 바로 뒤에 옵니다.  


##### Layer2, Layer3, Layer4
- 나중에 시간나면 추가...  


##### CODE
{% highlight ruby %}
procedure Init(rGHeader: PGLOBAL_HEADER); overload;
begin
  rGHeader^.magic_number := StrToInt('$A1B2C3D4');
  rGHeader^.version_major := 2;
  rGHeader^.version_minor := 4;
  rGHeader^.thiszone := 0;
  rGHeader^.sigfigs := 0;
  rGHeader^.snaplen := 65535;
  rGHeader^.network := 1;
end;

procedure Init(rPHeader: PPACKET_HEADER); overload;
begin
  rPHeader^.ts_sec := StrToInt('$5AA5438E');
  rPHeader^.ts_usec := 0;
  rPHeader^.incl_len := 0;
  rPHeader^.orig_len := 0;
end;

function GetGlobalHeaderBinary: TBytes;
var
  ms: TMemoryStream;
  rG: PGLOBAL_HEADER;
begin
  New(rG);
  Init(rG);

  ms := TMemoryStream.Create;
  ms.WriteData(rG, SizeOf(TGLOBAL_HEADER));

  ms.Position := 0;
  SetLength(Result, ms.Size);
  ms.ReadData(Result, ms.Size);

  ms.Free;
  Dispose(rG);
end;

function GetPacketHeaderBinary(b: TBytes): TBytes;
var
  ms: TMemoryStream;
  rP: PPACKET_HEADER;
begin
  New(rP);
  Init(rP);

  rP^.incl_len := Length(b);
  rP^.orig_len := Length(b);

  ms := TMemoryStream.Create;
  ms.WriteData(rP, SizeOf(TPACKET_HEADER));
  ms.WriteData(b, Length(b));

  ms.Position := 0;
  SetLength(Result, ms.Size);
  ms.ReadData(Result, ms.Size);

  ms.Free;
  Dispose(rP);
end;

function GetPcapBinary(b: TBytes): TBytes;
begin
  Result := GetGlobalHeaderBinary + GetPacketHeaderBinary(b);
end;
{% endhighlight %}  


##### 참고
- [https://wiki.wireshark.org/Development/LibpcapFileFormat](https://wiki.wireshark.org/Development/LibpcapFileFormat)
- [http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_Data_Types_for_API_Integration](http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_Data_Types_for_API_Integration)
- [http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_to_C%2B%2B_types_mapping](http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Delphi_to_C%2B%2B_types_mapping)
