---
layout: post
title:  "[delphi] 스마트 포인터"
date:   2018-03-29 00:00:00
categories: delphi
published: true
---
자동 객체 해제 클래스 테스트

- 함수 안에서 제한적 사용

- 개선 필요

- 코드

{% highlight delphi %}
unit uSmartPointer;

interface

function DoSmartPointer( out Reference: TObject; Instance: TObject ): IUnknown;

implementation

type
  TSmartPointer = class( TInterfacedObject )
  private
    FInstance: TObject;
  public
    constructor Create( AInstance: TObject );
    destructor Destroy; override;
  end;

{ TSmartPointer }

function DoSmartPointer( out Reference: TObject; Instance: TObject ): IUnknown;
begin
  Result := TSmartPointer.Create( Instance );
  TObject(Reference) := Instance;
end;

constructor TSmartPointer.Create(AInstance: TObject);
begin
  FInstance := AInstance;
end;

destructor TSmartPointer.Destroy;
begin
  FInstance.Free;

  inherited;
end;

end.
{% endhighlight %}

- 예                                                 

{% highlight delphi %}
    procedure GetData;                              
    var l: TList;                                   
    begin                                           
      DoSmartPointer( TObject( l ), TList.Create )  
    end;                                            
{% endhighlight %}    


참조: [https://msdn.microsoft.com/ko-kr/library/hh279674.aspx](https://msdn.microsoft.com/ko-kr/library/hh279674.aspx)