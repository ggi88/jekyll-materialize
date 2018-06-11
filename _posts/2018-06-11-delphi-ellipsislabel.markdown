---
layout: post
title:  "[delphi] Ellipsis Label"
date:   2018-06-11 00:00:00
categories: delphi
published: true
---

##### code
{% highlight ruby %}
procedure SetEllipsisLabel(l: TLabel);
var
  s: String;
  R: TRect;
begin
  s := l.Caption;
  UniqueString(s);
  R := l.ClientRect;
  l.Canvas.Font := l.Font;
  DrawText(l.Canvas.Handle, PChar(s), Length(s), R, DT_END_ELLIPSIS or DT_MODIFYSTRING or DT_NOPREFIX);
  l.Caption := s;
end;
{% endhighlight %}