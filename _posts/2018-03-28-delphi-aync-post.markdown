---
layout: post
title:  "[delphi] 비동기 함수"
date:   2018-03-28 00:00:00
categories: delphi
published: true
---
비동기로 지연된 코드 실행을 위해 작성

proc: 프로시저

nInterval: 지연 시간

{% highlight ruby %}
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
{% endhighlight %}