unit class_taylor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TTaylor = class
    Error: Real;
    x: real;
    TaylorType: Integer;
    function execute: Real;

    private
      step: Integer;
      xn,
      xnant,
      ErrorCal: real;
      function seno(): real;
      function coseno(): real;
      function e(): real;

      function factorial(m: Integer): Integer;
      function exponential(xx: real; m: Integer): real;

    public
      Lxn: TStringList;
      constructor create;
      destructor Destroy; override;

  end;

const
  F_SIN = 0;
  F_COS = 1;
  F_EXP = 2;

implementation

const
  MaxIteration = 10000;

constructor TTaylor.create;
begin
  Lxn:= TStringList.Create;
  xn:= 0;
  xnant:= 0;
  step:= 0;
  ErrorCal:= 1000000;

end;

destructor TTaylor.Destroy;
begin
   Lxn.Destroy;
end;

function TTaylor.execute: Real;
begin
     case TaylorType of
          F_SIN: Result:= seno();
          F_COS: Result:= coseno();
          F_EXP: Result:= e();

     end;
end;

function TTaylor.factorial(m: Integer): Integer;
begin
   if ( m < 2 ) then begin
     Result:= 1;
     exit;

   end;

   Result:= m * factorial( m - 1 );

end;

function TTaylor.exponential(xx: real; m: Integer): real;
var i: Integer;
begin
   Result:= 1;
   for i:= 1 to m do
      Result:= Result * xx;

end;

function TTaylor.seno: Real;
var StayInWhile: Boolean;
begin
  Lxn.Clear;
  step:= 0;
  xn:=0;
  StayInWhile:= ( ErrorCal >= Error );
  while StayInWhile do begin
      xnant:= xn;
      xn := xn + exponential( -1, step ) * exponential( x, 2 * step + 1 ) / (factorial( 2* step + 1 ));
      Lxn.Add( FloatToStr( xn ) );
      ErrorCal:= abs( xn - xnant );
      step:= step + 1;
      StayInWhile:= ( ErrorCal >= Error ) and (step < MaxIteration);
  end;
  Result:= xn;
end;

function TTaylor.coseno: Real;
var StayInWhile: Boolean;
begin
  Lxn.Clear;
  step:= 0;
  xn:=0;
  StayInWhile:= ( ErrorCal >= Error );
  while StayInWhile do begin
      xnant:= xn;
      xn := xn + exponential( -1, step ) * exponential( x, 2 * step ) / (factorial( 2* step ));
      Lxn.Add( FloatToStr( xn ) );
      ErrorCal:= abs( xn - xnant );
      step:= step + 1;
      StayInWhile:= ( ErrorCal >= Error ) and (step < MaxIteration);
  end;
  Result:= xn;
end;

function TTaylor.e: Real;
var StayInWhile: Boolean;
begin
  Lxn.Clear;
  step:= 0;
  xn:=0;
  StayInWhile:= ( ErrorCal >= Error );
  while StayInWhile do begin
      xnant:= xn;
      xn := xn + exponential( x, step ) / (factorial( step ));
      Lxn.Add( FloatToStr( xn ) );
      ErrorCal:= abs( xn - xnant );
      step:= step + 1;
      StayInWhile:= ( ErrorCal >= Error ) and (step < MaxIteration);
  end;
  Result:= xn;
end;

end.

