unit SpkMath;

{$mode ObjFpc}
{$H+}
{$DEFINE SPKMATH}
{.$Define EnhancedRecordSupport}

interface

{TODO: Zastanowiæ siê, czy wszystkie niejawne casty maj¹ sens}

uses
  Types, Math, SysUtils;

const
  NUM_ZERO = 1e-12;

type
  TRectCorner = (rcLeftTop, rcRightTop, rcLeftBottom, rcRightBottom);

  // Dwuwymiarowy wektor o ca³kowitych wspó³rzêdnych
  // Two-dimensional vector routines
  {$ifdef EnhancedRecordSupport}
  T2DIntVector = record
    x, y : integer;
  public
    constructor Create(Ax, Ay : integer);
    class operator Implicit(i : integer) : T2DIntVector;
    class operator Explicit(i : integer) : T2DIntVector;
    class operator Implicit(vector : T2DIntVector) : string;
    class operator Explicit(vector : T2DIntVector) : string;
    class operator Implicit(point : TPoint) : T2DIntVector;
    class operator Explicit(point : TPoint) : T2DIntVector;
    class operator Implicit(vector : T2DIntVector) : TPoint;
    class operator Explicit(vector : T2DIntVector) : TPoint;
    class operator Positive(vector : T2DIntVector) : T2DIntVector;
    class operator Negative(vector : T2DIntVector) : T2DIntVector;
    class operator Add(left, right : T2DIntVector) : T2DIntVector;
    class operator Subtract(left, right : T2DIntVector) : T2DIntVector;
    class operator Multiply(left, right : T2DIntVector) : integer;
    class operator Multiply(scalar : integer; right : T2DIntVector) : T2DIntVector;
    class operator Multiply(left : T2DIntVector; scalar : integer) : T2DIntVector;
    class operator Trunc(value : T2DIntVector) : T2DIntVector;
    class operator Round(value : T2DIntVector) : T2DIntVector;
    function DistanceTo(AVector : T2DIntVector) : double;
    function Length : extended;
  end;
  {$else}

  { T2DIntVector }

  T2DIntVector = object
    x, y : integer;
  public
    constructor Create(Ax, Ay : Integer);
    function DistanceTo(AVector : T2DIntVector) : double;
    function DistanceTo(Ax, Ay : Integer) : double;
    function Length : extended;
  end;
  {$endif}

  // Punkt w przestrzeni dwuwymiarowej o ca³kowitych wspó³rzêdnych
  // A point in two-dimensional space (integer numbers)
  T2DIntPoint = T2DIntVector;

  // Prostok¹t w przestrzeni dwuwymiarowej o ca³kowitych wspó³rzêdnych
  // Rectangle in two-dimensional space (integer numbers)
  {$ifdef EnhancedRecordSupport}
  T2DIntRect = record
  public
    constructor Create(ALeft, ATop, ARight, ABottom : integer); overload;
    constructor Create(ATopLeft : T2DIntVector; ABottomRight : T2DIntVector); overload;
    class operator Implicit(ARect : T2DIntRect) : TRect;
    class operator Explicit(ARect : T2DIntRect) : TRect;
    class operator Implicit(ARect : TRect) : T2DIntRect;
    class operator Explicit(ARect : TRect) : T2DIntRect;
    class operator Implicit(ARect : T2DIntRect) : string;
    class operator Explicit(ARect : T2DIntRect) : string;
    class operator Add(ARect : T2DIntRect; AVector : T2DIntVector) : T2DIntRect;
    class operator Add(AVector : T2DIntVector; ARect : T2DIntRect) : T2DIntRect;
    class operator Subtract(ARect : T2DIntRect; AVector : T2DIntVector) : T2DIntRect;
    class operator Subtract(AVector : T2DIntVector; ARect : T2DIntRect) : T2DIntRect;
    function Contains(APoint : T2DIntPoint) : boolean;
    function IntersectsWith(ARect : T2DIntRect) : boolean; overload;
    function IntersectsWith(ARect : T2DIntRect; var Intersection : T2DIntRect) : boolean; overload;
    procedure Move(dx, dy : integer); overload;
    procedure Move(AVector : T2DIntVector); overload;
    function Moved(dx, dy : integer) : T2DIntRect; overload;
    function Moved(AVector : T2DIntVector) : T2DIntRect; overload;
    function GetVertex(ACorner : TRectCorner) : T2DIntVector;
    procedure Split(var LeftTop, RightTop, LeftBottom, RightBottom : T2DIntRect);
    procedure ExpandBy(APoint : T2DIntPoint);
    function Width : integer;
    function Height : integer;
    function ForWinAPI : TRect;
  case integer of
     0 : (Left, Top, Right, Bottom : integer);
     1 : (TopLeft : T2DIntVector; BottomRight : T2DIntVector);
  end;
  {$else}

  { T2DIntRect }

  T2DIntRect = object
    Left, Top, Right, Bottom: integer;
    //todo
    //TopLeft : T2DIntVector;
    //BottomRight : T2DIntVector;
  public
    constructor Create(ALeft, ATop, ARight, ABottom : integer); overload;
    constructor Create(ATopLeft : T2DIntVector; ABottomRight : T2DIntVector); overload;
    function Contains(APoint : T2DIntPoint) : boolean;
    function Contains(Ax, Ay : Integer) : boolean;
    function IntersectsWith(ARect : T2DIntRect) : boolean; overload;
    function IntersectsWith(ARect : T2DIntRect; var Intersection : T2DIntRect) : boolean; overload;
    procedure Move(dx, dy : integer); overload;
    procedure Move(AVector : T2DIntVector); overload;
    function Moved(dx, dy : integer) : T2DIntRect; overload;
    function Moved(AVector : T2DIntVector) : T2DIntRect; overload;
    function GetVertex(ACorner : TRectCorner) : T2DIntVector;
    procedure Split(var LeftTop, RightTop, LeftBottom, RightBottom : T2DIntRect);
    procedure ExpandBy(APoint : T2DIntPoint);
    function Width : integer;
    function Height : integer;
    function ForWinAPI : TRect;
  end;
  {$endif}

  // Wektor w przestrzeni dwuwymiarowej o rzeczywistych wspó³rzêdnych
  // Vector in two-dimensional space (floating point numbers)
  //todo change from extended to double
  {$ifdef EnhancedRecordSupport}
  T2DVector = record
    x, y : extended;
  public
    constructor Create(Ax, Ay : extended);
    class operator Implicit(i : integer) : T2DVector;
    class operator Explicit(i : integer) : T2DVector;
    class operator Implicit(e : extended) : T2DVector;
    class operator Explicit(e : extended) : T2DVector;
    class operator Implicit(vector : T2DVector) : string;
    class operator Explicit(vector : T2DVector) : string;
    class operator Implicit(vector : T2DIntVector) : T2DVector;
    class operator Explicit(vector : T2DIntVector) : T2DVector;
    class operator Implicit(vector : T2DVector) : T2DIntVector;
    class operator Explicit(vector : T2DVector) : T2DIntVector;
    class operator Positive(vector : T2DVector) : T2DVector;
    class operator Negative(vector : T2DVector) : T2DVector;
    class operator Add(left, right : T2DVector) : T2DVector;
    class operator Subtract(left, right : T2DVector) : T2DVector;
    class operator Multiply(left, right : T2DVector) : extended;
    class operator Multiply(scalar : extended; right : T2DVector) : T2DVector;
    class operator Multiply(left : T2DVector; scalar : extended) : T2DVector;
    class operator Divide(left : T2DIntVector; scalar : extended) : T2DVector;
    class operator Divide(left : T2DVector; scalar : extended) : T2DVector;
    class operator Trunc(vector : T2DVector) : T2DIntVector;
    class operator Round(vector : T2DVector) : T2DIntVector;
    function Length : extended;
    procedure Normalize;
    function Normalized : T2DVector;
    function UpNormal : T2DVector;
    function DownNormal : T2DVector;
    procedure ProjectTo(vector : T2DVector);
    function ProjectedTo(vector : T2DVector) : T2DVector;
    function Scale(dx, dy : extended) : T2DVector;
    function LiesInsideCircle(APoint : T2DVector; radius : extended) : boolean;
    function OrientationWith(AVector : T2DVector) : integer;
    function CrossProductWith(AVector : T2DVector) : extended;
    function DistanceFromAxis(APoint : T2DVector; AVector : T2DVector) : extended;
  end;
  {$else}
  T2DVector = object
    x, y : extended;
  public
    constructor Create(Ax, Ay : extended);
    function Length : extended;
    procedure Normalize;
    function Normalized : T2DVector;
    function UpNormal : T2DVector;
    function DownNormal : T2DVector;
    procedure ProjectTo(vector : T2DVector);
    function ProjectedTo(vector : T2DVector) : T2DVector;
    function Scale(dx, dy : extended) : T2DVector;
    function LiesInsideCircle(APoint : T2DVector; radius : extended) : boolean;
    function OrientationWith(AVector : T2DVector) : integer;
    function CrossProductWith(AVector : T2DVector) : extended;
    function DistanceFromAxis(APoint : T2DVector; AVector : T2DVector) : extended;
  end;
  {$endif}

  // Punkt w przestrzeni dwuwymiarowej o rzeczywistych wspó³rzêdnych
  // A point in two-dimensional space (floating point numbers)
  T2DPoint = T2DVector;

  // Prostok¹t w przestrzeni dwuwymiarowej o rzeczywistych wspó³rzêdnych
  // Rectangle in two-dimensional space (floating point numbers)
  {$ifdef EnhancedRecordSupport}
  T2DRect = record
  public
    constructor Create(ALeft, ATop, ARight, ABottom : extended); overload;
    constructor Create(ATopLeft : T2DVector; ABottomRight : T2DVector); overload;
    class operator Implicit(ARect : T2DRect) : TRect;
    class operator Explicit(ARect : T2DRect) : TRect;
    class operator Implicit(ARect : TRect) : T2DRect;
    class operator Explicit(ARect : TRect) : T2DRect;
    class operator Implicit(ARect : T2DRect) : T2DIntRect;
    class operator Explicit(ARect : T2DRect) : T2DIntRect;
    class operator Implicit(ARect : T2DIntRect) : T2DRect;
    class operator Explicit(ARect : T2DIntRect) : T2DRect;
    class operator Implicit(ARect : T2DRect) : string;
    class operator Explicit(ARect : T2DRect) : string;
    function Contains(APoint : T2DPoint) : boolean;
    function IntersectsWith(ARect : T2DRect) : boolean;
    procedure Move(dx, dy : extended); overload;
    procedure Move(Vector : T2DVector); overload;
    function Moved(dx, dy : extended) : T2DRect; overload;
    function Moved(Vector : T2DVector) : T2DRect; overload;
    function GetVertex(ACorner : TRectCorner) : T2DVector;
    procedure Split(var LeftTop, RightTop, LeftBottom, RightBottom : T2DRect);
    procedure ExpandBy(APoint : T2DPoint);
    function Width : extended;
    function Height : extended;
    procedure SetCenteredWidth(ANewWidth : extended);
    procedure SetCenteredHeight(ANewHeight : extended);
  case integer of
      0 : (Left, Top, Right, Bottom : extended);
      1 : (TopLeft : T2DVector; BottomRight : T2DVector);
  end;
  {$else}
  T2DRect = object
    Left, Top, Right, Bottom : extended;
    //todo
    //TopLeft : T2DVector; BottomRight : T2DVector;
  public
    constructor Create(ALeft, ATop, ARight, ABottom : extended); overload;
    constructor Create(ATopLeft : T2DVector; ABottomRight : T2DVector); overload;
    function Contains(APoint : T2DPoint) : boolean;
    function IntersectsWith(ARect : T2DRect) : boolean;
    procedure Move(dx, dy : extended); overload;
    procedure Move(Vector : T2DVector); overload;
    function Moved(dx, dy : extended) : T2DRect; overload;
    function Moved(Vector : T2DVector) : T2DRect; overload;
    function GetVertex(ACorner : TRectCorner) : T2DVector;
    procedure Split(var LeftTop, RightTop, LeftBottom, RightBottom : T2DRect);
    procedure ExpandBy(APoint : T2DPoint);
    function Width : extended;
    function Height : extended;
    procedure SetCenteredWidth(ANewWidth : extended);
    procedure SetCenteredHeight(ANewHeight : extended);
  end;
  {$endif}

  // Wektor w przestrzeni trójwymiarowej o rzeczywistych wspó³rzêdnych
  // Vector in three-dimensional space (floating point numbers)
  {$ifdef EnhancedRecordSupport}
  T3DVector = record
    x, y, z : extended;
  public
    constructor create(Ax, Ay, Az : extended);
    class operator Implicit(i : integer) : T3DVector;
    class operator Explicit(i : integer) : T3DVector;
    class operator Implicit(e : extended) : T3DVector;
    class operator Explicit(e : extended) : T3DVector;
    class operator Implicit(vector : T2DIntVector) : T3DVector;
    class operator Explicit(vector : T2DIntVector) : T3DVector;
    class operator Implicit(vector : T2DVector) : T3DVector;
    class operator Explicit(vector : T2DVector) : T3DVector;
    class operator Implicit(vector : T3DVector) : string;
    class operator Explicit(vector : T3DVector) : string;
    class operator Negative(vector : T3DVector) : T3DVector;
    class operator Positive(vector : T3DVector) : T3DVector;
    class operator Add(left, right : T3DVector) : T3DVector;
    class operator Subtract(left, right : T3DVector) : T3DVector;
    class operator Multiply(left, right : T3DVector) : extended;
    class operator Multiply(scalar : extended; right : T3DVector) : T3DVector;
    class operator Multiply(left : T3DVector; scalar : extended) : T3DVector;
    class operator Divide(left : T3DVector; scalar : extended) : T3DVector;
    function Length : extended;
    procedure Normalize;
    function Normalized : T3DVector;
    function UpNormalTo(vector : T3DVector) : T3DVector;
    function DownNormalTo(vector : T3DVector) : T3DVector;
    procedure ProjectTo(vector : T3DVector);
    function ProjectedTo(vector : T3DVector) : T3DVector;
    function Scale(dx, dy, dz : extended) : T3DVector;
    function LiesInsideSphere(APoint : T3DVector; radius : extended) : boolean;
    function DistanceFromAxis(APoint : T3DVector; AVector : T3DVector) : extended;
  end;
  {$else}
  T3DVector = object
    x, y, z : extended;
  public
    constructor create(Ax, Ay, Az : extended);
    function Length : extended;
    procedure Normalize;
    function Normalized : T3DVector;
    function UpNormalTo(vector : T3DVector) : T3DVector;
    function DownNormalTo(vector : T3DVector) : T3DVector;
    procedure ProjectTo(vector : T3DVector);
    function ProjectedTo(vector : T3DVector) : T3DVector;
    function Scale(dx, dy, dz : extended) : T3DVector;
    function LiesInsideSphere(APoint : T3DVector; radius : extended) : boolean;
    function DistanceFromAxis(APoint : T3DVector; AVector : T3DVector) : extended;
  end;
  {$endif}

  {$ifndef EnhancedRecordSupport}

  function Create2DIntVector(Ax, Ay : Integer): T2DIntVector;

  function Create2DIntPoint(Ax, Ay : Integer): T2DIntPoint;

  function Create2DIntRect(ALeft, ATop, ARight, ABottom: Integer): T2DIntRect;

  operator - (Left: T2DIntVector; Right: T2DIntVector): T2DIntVector;

  operator := (APoint: T2DIntPoint): TPoint;

  operator := (APoint: TPoint): T2DIntPoint;

  operator - (Left: T2DIntRect; Right: T2DIntVector): T2DIntRect;

  operator + (Left: T2DIntRect; Right: T2DIntVector): T2DIntRect;

  operator := (ARect: TRect): T2DIntRect;

  operator - (Left: T2DVector; Right: T2DVector): T2DVector;

  operator - (Left: T3DVector; Right: T3DVector): T3DVector;
  {$endif}

  procedure EnsureOrder(var a, b: Integer);

implementation

{$ifndef EnhancedRecordSupport}

function Create2DIntVector(Ax, Ay: Integer): T2DIntVector;
begin
  Result.Create(Ax, Ay);
end;

function Create2DIntPoint(Ax, Ay: Integer): T2DIntPoint;
begin
  Result.Create(Ax, Ay);
end;

function Create2DIntRect(ALeft, ATop, ARight, ABottom: Integer): T2DIntRect;
begin
  Result.Create(ALeft, ATop, ARight, ABottom);
end;

operator - (Left: T2DIntVector; Right: T2DIntVector): T2DIntVector;
begin
  Result.x := Left.x - Right.x;
  Result.y := Left.y - Right.y;
end;

operator := (APoint: T2DIntPoint): TPoint;
begin
  Result.x := APoint.x;
  Result.y := APoint.y;
end;

operator := (APoint: TPoint): T2DIntPoint;
begin
  Result.x := APoint.x;
  Result.y := APoint.y;
end;

operator - (Left: T2DIntRect; Right: T2DIntVector): T2DIntRect;
begin
  Result.Create(Left.Left - Right.x, Left.Top - Right.y,
    Left.Right - Right.x, Left.Bottom - Right.y);
end;

operator + (Left: T2DIntRect; Right: T2DIntVector): T2DIntRect;
begin
  Result.Create(Left.left + Right.x, Left.top + Right.y,
    Left.Right + Right.x, Left.bottom + Right.y);
end;

operator := (ARect: TRect): T2DIntRect;
begin
  Result.Left := ARect.Left;
  Result.Top := ARect.Top;
  Result.Right := ARect.Right;
  Result.Bottom := ARect.Bottom;
end;

operator - (Left: T2DVector; Right: T2DVector): T2DVector;
begin
  Result.x := Left.x - Right.x;
  Result.y := Left.y - Right.y;
end;

operator - (Left: T3DVector; Right: T3DVector): T3DVector;
begin
  Result.x := Left.x - Right.x;
  Result.y := Left.y - Right.y;
  Result.z := Left.z - Right.z;
end;

{$endif}

{ T2DIntVector }

constructor T2DIntVector.Create(Ax, Ay: integer);
begin
  self.x:=Ax;
  self.y:=Ay;
end;

function T2DIntVector.DistanceTo(AVector: T2DIntVector): double;
begin
  result:=sqrt(sqr(self.x - AVector.x) + sqr(self.y - AVector.y));
end;

function T2DIntVector.DistanceTo(Ax, Ay: Integer): double;
begin
  Result := sqrt(sqr(x - Ax) + sqr(y - Ay));
end;

function T2DIntVector.Length: extended;
begin
   result:=sqrt(sqr(Self.x)+sqr(self.y));
end;

{$ifdef EnhancedRecordSupport}

class operator T2DIntVector.Add(left, right: T2DIntVector): T2DIntVector;
begin
  result.x:=left.x+right.x;
  result.y:=left.y+right.y;
end;

class operator T2DIntVector.Explicit(i: integer): T2DIntVector;
begin
  result.x:=i;
  result.y:=0;
end;

class operator T2DIntVector.Explicit(vector: T2DIntVector): string;
begin
  result:='[x='+IntToStr(vector.x)+'; y='+IntToStr(vector.y)+']';
end;

class operator T2DIntVector.Implicit(vector: T2DIntVector): string;
begin
  result:='[x='+IntToStr(vector.x)+'; y='+IntToStr(vector.y)+']';
end;

class operator T2DIntVector.Implicit(i: integer): T2DIntVector;
begin
  result.x:=i;
  result.y:=0;
end;

class operator T2DIntVector.Multiply(left: T2DIntVector;
  scalar: integer): T2DIntVector;
begin
  result.x:=left.x*scalar;
  result.y:=left.y*scalar;
end;

class operator T2DIntVector.Multiply(left, right: T2DIntVector): integer;
begin
  result:=left.x*right.x + left.y*right.y;
end;

class operator T2DIntVector.Multiply(scalar: integer;
  right: T2DIntVector): T2DIntVector;
begin
  result.x:=scalar*right.x;
  result.y:=scalar*right.y;
end;

class operator T2DIntVector.Negative(vector: T2DIntVector): T2DIntVector;
begin
  result.x:=-vector.x;
  result.y:=-vector.y;
end;

class operator T2DIntVector.Positive(vector: T2DIntVector): T2DIntVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

class operator T2DIntVector.Round(value: T2DIntVector): T2DIntVector;
begin
  result.x:=value.x;
  result.y:=value.y;
end;

class operator T2DIntVector.Subtract(left, right: T2DIntVector): T2DIntVector;
begin
  result.x:=left.x-right.x;
  result.y:=left.y-right.y;
end;

class operator T2DIntVector.Trunc(value: T2DIntVector): T2DIntVector;
begin
  result.x:=value.x;
  result.y:=value.y;
end;

class operator T2DIntVector.Explicit(point: TPoint): T2DIntVector;
begin
  result.x:=point.x;
  result.y:=point.y;
end;

class operator T2DIntVector.Explicit(vector: T2DIntVector): TPoint;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

class operator T2DIntVector.Implicit(point: TPoint): T2DIntVector;
begin
  result.x:=point.x;
  result.y:=point.y;
end;

class operator T2DIntVector.Implicit(vector: T2DIntVector): TPoint;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

{$endif}

{ T2DVector }

constructor T2DVector.Create(Ax, Ay: extended);
begin
  self.x:=Ax;
  self.y:=Ay;
end;

function T2DVector.DistanceFromAxis(APoint, AVector: T2DVector): extended;

var temp, proj : T2DVector;

begin
  temp:=self-APoint;
  proj:=temp.ProjectedTo(AVector);
  result:=(temp - proj).Length;
  //todo: see if the below (without operator overloading) is faster
  {
  temp.x := x - APoint.x;
  temp.y := y - APoint.y;
  proj := temp.ProjectedTo(AVector);
  temp.x := temp.x - proj.x;
  temp.y := temp.y - proj.y;
  Result := temp.Length;
  }
end;

function T2DVector.DownNormal: T2DVector;

var len : extended;

begin
len:=self.Length;
if len<NUM_ZERO then
   raise exception.create('T2DVector.DownNormal: Cannot normalize a vector of zero length!');
   //raise exception.create('T2DVector.DownNormal: Nie mogê obliczyæ normalnej do wektora zerowego!');

if self.x>0 then
   begin
   result.x:=self.y/len;
   result.y:=-self.x/len;
   end
else
   begin
   result.x:=-self.y/len;
   result.y:=self.x/len;
   end;
end;

function T2DVector.Length: extended;
begin
  result:=sqrt(sqr(self.x)+sqr(self.y));
end;

function T2DVector.LiesInsideCircle(APoint: T2DPoint;
  radius: extended): boolean;

var Temp : T2DVector;

begin
  Temp:=APoint - self;
  result:=Temp.Length <= radius;
  //todo: see if below is faster/better
  {
  Temp.x:=APoint.x - x;
  Temp.y:=APoint.y - y;
  result:=Temp.Length <= radius;
  }
end;

procedure T2DVector.Normalize;

var len : extended;

begin
  len:=self.Length;
  if len<NUM_ZERO then
     raise exception.create('T2DVector.Normalize: Cannot normalize a vector of zero length!');
     //raise exception.create('T2DVector.Normalize: Nie mo¿na znormalizowaæ wektora zerowego!');
  self.x:=self.x/len;
  self.y:=self.y/len;
end;

function T2DVector.Normalized: T2DVector;

var len : extended;

begin
  len:=self.Length;
  if len<NUM_ZERO then
     raise exception.create('T2DVector.Normalize: Cannot normalize a vector of zero length!');
     //raise exception.create('T2DVector.Normalized: Nie mo¿na obliczyæ normy wektora zerowego!');
  result.x:=self.x/len;
  result.y:=self.y/len;
end;

function T2DVector.OrientationWith(AVector: T2DVector): integer;

var product : extended;

begin
  product:=self.CrossProductWith(AVector);
  if product<NUM_ZERO then result:=-1 else
     if product>NUM_ZERO then result:=1 else
        result:=0;
end;

function T2DVector.CrossProductWith(AVector: T2DVector): extended;
begin
  result:=self.x * AVector.y - self.y * AVector.x;
end;

function T2DVector.ProjectedTo(vector: T2DVector): T2DVector;

var product : extended;
    len : extended;

begin
  len:=vector.Length;
  if abs(len)<NUM_ZERO then
     raise exception.create('T2DVector.ProjectedTo: Cannot project onto a vector of zero length!');
     //raise exception.create('T2DVector.ProjectedTo: Nie mo¿na rzutowaæ na wektor zerowy!');

  product:=self.x*vector.x + self.y*vector.y;
  result.x:=(vector.x * product) / sqr(len);
  result.y:=(vector.y * product) / sqr(len);
end;

procedure T2DVector.ProjectTo(vector: T2DVector);

var product : extended;
    len : extended;

begin
  len:=vector.Length;
  if abs(len)<NUM_ZERO then
     raise exception.create('T2DVector.ProjectTo: Cannot project onto a vector of zero length!');
//     raise exception.create('T2DVector.ProjectTo: Nie mo¿na rzutowaæ na wektor zerowy!');

  product:=self.x*vector.x + self.y*vector.y;

  self.x:=(vector.x * product) / sqr(len);
  self.y:=(vector.y * product) / sqr(len);
end;

function T2DVector.Scale(dx, dy: extended): T2DVector;
begin
  result.x:=self.x * dx;
  result.y:=self.y * dy;
end;


function T2DVector.UpNormal : T2DVector;

var len : extended;

begin
len:=self.Length;
if len<NUM_ZERO then
   raise exception.create('T2DVector.UpNormal: Cannot normalize a vector of zero length!');
   //raise exception.create('T2DVector.UpNormal: Nie mogê obliczyæ normalnej do wektora zerowego!');

if self.x>0 then
   begin
   result.x:=-self.y/len;
   result.y:=self.x/len;
   end
else
   begin
   result.x:=self.y/len;
   result.y:=-self.x/len;
   end;
end;

{$ifdef EnhancedRecordSupport}

class operator T2DVector.Add(left, right: T2DVector): T2DVector;
begin
  result.x:=left.x+right.x;
  result.y:=left.y+right.y;
end;

class operator T2DVector.Divide(left: T2DIntVector;
  scalar: extended): T2DVector;
begin
  if abs(scalar)<NUM_ZERO then
     raise exception.create('T2DVector.Divide: Division by zero!');
     //raise exception.create('T2DVector.Divide: Dzielenie przez zero!');
  result.x:=left.x/scalar;
  result.y:=left.y/scalar;
end;

class operator T2DVector.Divide(left: T2DVector; scalar: extended): T2DVector;
begin
  if abs(scalar)<NUM_ZERO then
     raise exception.create('T2DVector.Divide: Division by zero!');
     //raise exception.create('T2DVector.Divide: Dzielenie przez zero!');
  result.x:=left.x/scalar;
  result.y:=left.y/scalar;
end;

class operator T2DVector.Explicit(vector: T2DVector): string;
begin
  result:='[x='+FloatToStr(vector.x)+'; y='+FloatToStr(vector.y)+']';
end;

class operator T2DVector.Explicit(i: integer): T2DVector;
begin
  result.x:=i;
  result.y:=0;
end;

class operator T2DVector.Explicit(e: extended): T2DVector;
begin
  result.x:=e;
  result.y:=0;
end;

class operator T2DVector.Explicit(vector: T2DIntVector): T2DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

class operator T2DVector.Explicit(vector: T2DVector): T2DIntVector;
begin
  result.x:=round(vector.x);
  result.y:=round(vector.y);
end;

class operator T2DVector.Implicit(vector: T2DVector): string;
begin
  result:='[x='+FloatToStr(vector.x)+'; y='+FloatToStr(vector.y)+']';
end;

class operator T2DVector.Implicit(vector: T2DIntVector): T2DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

class operator T2DVector.Implicit(i: integer): T2DVector;
begin
  result.x:=i;
  result.y:=0;
end;

class operator T2DVector.Implicit(e: extended): T2DVector;
begin
  result.x:=e;
  result.y:=0;
end;

class operator T2DVector.Implicit(vector: T2DVector): T2DIntVector;
begin
  result.x:=round(vector.x);
  result.y:=round(vector.y);
end;

class operator T2DVector.Multiply(left, right: T2DVector): extended;
begin
  result:=left.x*right.x + left.y*right.y;
end;

class operator T2DVector.Multiply(left: T2DVector; scalar: extended): T2DVector;
begin
  result.x:=left.x*scalar;
  result.y:=left.y*scalar;
end;

class operator T2DVector.Multiply(scalar: extended;
  right: T2DVector): T2DVector;
begin
  result.x:=scalar*right.x;
  result.y:=scalar*right.y;
end;

class operator T2DVector.Negative(vector: T2DVector): T2DVector;
begin
  result.x:=-vector.x;
  result.y:=-vector.y;
end;

class operator T2DVector.Positive(vector: T2DVector): T2DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
end;

class operator T2DVector.Round(vector: T2DVector): T2DIntVector;
begin
  result.x:=round(vector.x);
  result.y:=round(vector.y);
end;

class operator T2DVector.Subtract(left, right: T2DVector): T2DVector;
begin
  result.x:=left.x-right.x;
  result.y:=left.y-right.y;
end;

class operator T2DVector.Trunc(vector: T2DVector): T2DIntVector;
begin
  result.x:=trunc(vector.x);
  result.y:=trunc(vector.y);
end;

{$endif}

{ T3DVector }

constructor T3DVector.create(Ax, Ay, Az: extended);
begin
  self.x:=Ax;
  self.y:=Ay;
  self.z:=Az;
end;

function T3DVector.DistanceFromAxis(APoint, AVector: T3DVector): extended;

var temp, proj : T3DVector;

begin
  temp:=self-APoint;
  proj:=temp.ProjectedTo(AVector);
  result:=(temp - proj).Length;
end;

function T3DVector.DownNormalTo(vector: T3DVector): T3DVector;

var len : extended;

begin
  result.x:=self.y * vector.z - self.z * vector.y;
  result.y:=-(self.x * vector.z - self.z * vector.x);
  result.z:=self.x * vector.y - self.y * vector.x;
  len:=result.Length;
  if len<NUM_ZERO then
     raise exception.create('T3DVector.DownNormalTo: Vector length is zero!');
     //raise exception.create('T3DVector.DownNormalTo: Nie mogê obliczyæ normalnej: wektory le¿¹ na wspólnej prostej!');
  result.x:=result.x/len;
  result.y:=result.y/len;
  result.z:=result.z/len;

  if result.y>0 then
     begin
     result.x:=-result.x;
     result.y:=-result.y;
     result.z:=-result.z;
     end;
end;

function T3DVector.Length: extended;
begin
  result:=sqrt(sqr(self.x)+sqr(self.y)+sqr(self.z));
end;

function T3DVector.LiesInsideSphere(APoint: T3DVector;
  radius: extended): boolean;

var Temp : T3DVector;

begin
  Temp:=APoint - self;
  result:=Temp.Length <= radius;
end;


procedure T3DVector.Normalize;

var len : extended;

begin
  len:=self.Length;
  if len<NUM_ZERO then
     raise exception.create('T3DVector.Normalize: Vector length is zero!');
     //raise exception.create('T3DVector.Normalize: Nie mo¿na znormalizowaæ wektora zerowego!');
  self.x:=self.x/len;
  self.y:=self.y/len;
  self.z:=self.z/len;
end;

function T3DVector.Normalized: T3DVector;

var len : extended;

begin
  len:=self.Length;
  if len<NUM_ZERO then
     raise exception.create('T3DVector.Normalized: Vector length is zero!');
     //raise exception.create('T3DVector.Normalized: Nie mo¿na obliczyæ normy wektora zerowego!');
  result.x:=self.x/len;
  result.y:=self.y/len;
  result.z:=self.z/len;
end;


function T3DVector.ProjectedTo(vector: T3DVector): T3DVector;

var product : extended;
    len : extended;

begin
  len:=vector.Length;
  if abs(len)<NUM_ZERO then
     raise exception.create('T3DVector.ProjectedTo: Vector length is zero!');
     //raise exception.create('T3DVector.ProjectedTo: Nie mo¿na rzutowaæ na wektor zerowy!');

  product:=self.x*vector.x + self.y*vector.y + self.z*vector.z;
  result.x:=(vector.x * product) / sqr(len);
  result.y:=(vector.y * product) / sqr(len);
  result.z:=(vector.z * product) / sqr(len);
end;

procedure T3DVector.ProjectTo(vector: T3DVector);

var product : extended;
    len : extended;

begin
  len:=vector.Length;
  if abs(len)<NUM_ZERO then
     raise exception.create('T3DVector.ProjectTo: Vector length is zero!');
     //raise exception.create('T3DVector.ProjectTo: Nie mo¿na rzutowaæ na wektor zerowy!');

  product:=self.x*vector.x + self.y*vector.y + self.z*vector.z;
  self.x:=(vector.x * product) / sqr(len);
  self.y:=(vector.y * product) / sqr(len);
  self.z:=(vector.z * product) / sqr(len);
end;

function T3DVector.Scale(dx, dy, dz: extended): T3DVector;
begin
  result.x:=self.x * dx;
  result.y:=self.y * dy;
  result.z:=self.z * dz;
end;

function T3DVector.UpNormalTo(vector: T3DVector): T3DVector;

var len : extended;

begin
  result.x:=self.y * vector.z - self.z * vector.y;
  result.y:=-(self.x * vector.z - self.z * vector.x);
  result.z:=self.x * vector.y - self.y * vector.x;

  len:=result.Length;
  if len<NUM_ZERO then
     raise exception.create('T3DVector.UpNormalTo: Vector length is zero!');
     //raise exception.create('T3DVector.UpNormalTo: Nie mogê obliczyæ normalnej: wektory le¿¹ na wspólnej prostej!');
  result.x:=result.x/len;
  result.y:=result.y/len;
  result.z:=result.z/len;

  if result.y<0 then
     begin
     result.x:=-result.x;
     result.y:=-result.y;
     result.z:=-result.z;
     end;
end;


{$ifdef EnhancedRecordSupport}

class operator T3DVector.Add(left, right: T3DVector): T3DVector;
begin
  result.x:=left.x+right.x;
  result.y:=left.y+right.y;
  result.z:=left.z+right.z;
end;

class operator T3DVector.Divide(left: T3DVector; scalar: extended): T3DVector;
begin
  if abs(scalar)<NUM_ZERO then
     raise exception.create('T3DVector.Divide: Division by zero!');
     //raise exception.create('T3DVector.Divide: Dzielenie przez zero!');
  result.x:=left.x/scalar;
  result.y:=left.y/scalar;
  result.z:=left.z/scalar;
end;

class operator T3DVector.Explicit(vector: T2DIntVector): T3DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
  result.z:=0;
end;

class operator T3DVector.Explicit(i: integer): T3DVector;
begin
  result.x:=i;
  result.y:=0;
  result.z:=0;
end;

class operator T3DVector.Explicit(e: extended): T3DVector;
begin
  result.x:=e;
  result.y:=0;
  result.z:=0;
end;

class operator T3DVector.Explicit(vector: T2DVector): T3DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
  result.z:=0;
end;

class operator T3DVector.Explicit(vector: T3DVector): string;
begin
  result:='[x='+FloatToStr(vector.x)+'; y='+FloatToStr(vector.y)+'; z='+FloatToStr(vector.z)+']';
end;

class operator T3DVector.Implicit(vector: T2DIntVector): T3DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
  result.z:=0;
end;

class operator T3DVector.Implicit(vector: T2DVector): T3DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
  result.z:=0;
end;

class operator T3DVector.Implicit(i: integer): T3DVector;
begin
  result.x:=i;
  result.y:=0;
  result.z:=0;
end;

class operator T3DVector.Implicit(e: extended): T3DVector;
begin
  result.x:=e;
  result.y:=0;
  result.z:=0;
end;

class operator T3DVector.Implicit(vector: T3DVector): string;
begin
  result:='[x='+FloatToStr(vector.x)+'; y='+FloatToStr(vector.y)+'; z='+FloatToStr(vector.z)+']';
end;

class operator T3DVector.Multiply(left: T3DVector; scalar: extended): T3DVector;
begin
  result.x:=left.x*scalar;
  result.y:=left.y*scalar;
  result.z:=left.z*scalar;
end;

class operator T3DVector.Multiply(scalar: extended;
  right: T3DVector): T3DVector;
begin
  result.x:=scalar*right.x;
  result.y:=scalar*right.y;
  result.z:=scalar*right.z;
end;

class operator T3DVector.Multiply(left, right: T3DVector): extended;
begin
  result:=left.x*right.x + left.y*right.y + left.z*right.z;
end;

class operator T3DVector.Negative(vector: T3DVector): T3DVector;
begin
  result.x:=-vector.x;
  result.y:=-vector.y;
  result.z:=-vector.z;
end;

class operator T3DVector.Positive(vector: T3DVector): T3DVector;
begin
  result.x:=vector.x;
  result.y:=vector.y;
  result.z:=vector.z;
end;

class operator T3DVector.Subtract(left, right: T3DVector): T3DVector;
begin
  result.x:=left.x-right.x;
  result.y:=left.y-right.y;
  result.z:=left.z-right.z;
end;

{$endif}


{ T2DIntRect }

constructor T2DIntRect.Create(ALeft, ATop, ARight, ABottom: integer);
begin
  self.left:=ALeft;
  self.top:=ATop;
  self.right:=ARight;
  self.bottom:=ABottom;
end;

constructor T2DIntRect.Create(ATopLeft, ABottomRight: T2DIntVector);
begin
  {$ifdef EnhancedRecordSupport}
  self.TopLeft:=ATopLeft;
  self.BottomRight:=ABottomRight;
  {$else}
  Left := ATopLeft.x;
  Top := ATopLeft.y;
  Right := ABottomRight.x;
  Bottom := ABottomRight.y;
  {$endif}
end;

function T2DIntRect.Contains(APoint: T2DIntPoint): boolean;
begin
  result:=(APoint.x>=self.Left) and (APoint.x<=self.Right) and
        (APoint.y>=self.Top) and (APoint.y<=self.Bottom);
end;

function T2DIntRect.Contains(Ax, Ay: Integer): boolean;
begin
  result:=(Ax>=Left) and (Ax<=Right) and
        (Ay>=Top) and (Ay<=Bottom);
end;

procedure T2DIntRect.ExpandBy(APoint: T2DIntPoint);
begin
  self.left:=min(self.left,APoint.x);
  self.right:=max(self.right,APoint.x);
  self.top:=min(self.top,APoint.y);
  self.bottom:=max(self.bottom,APoint.y);
end;

function T2DIntRect.GetVertex(ACorner: TRectCorner): T2DIntVector;
begin
  {$ifdef EnhancedRecordSupport}
  case ACorner of
    rcLeftTop : result:=T2DIntVector.create(self.left, self.top);
    rcRightTop : result:=T2DIntVector.create(self.right, self.top);
    rcLeftBottom : result:=T2DIntVector.create(self.left, self.bottom);
    rcRightBottom : result:=T2DIntVector.create(self.right, self.bottom);
  end;
  {$else}
  case ACorner of
    rcLeftTop : result.create(self.left, self.top);
    rcRightTop : result.create(self.right, self.top);
    rcLeftBottom : result.create(self.left, self.bottom);
    rcRightBottom : result.create(self.right, self.bottom);
  end;
  {$endif}
end;

function T2DIntRect.Height: integer;
begin
  result:=self.bottom-self.top+1;
end;

function T2DIntRect.IntersectsWith(ARect : T2DIntRect;
  var Intersection: T2DIntRect): boolean;

var XStart, XWidth, YStart, YWidth : integer;

begin
if self.left<=ARect.left then
   begin
   if ARect.left<=self.right then
      begin
      XStart:=ARect.Left;
      XWidth:=min(ARect.right, self.Right) - ARect.left + 1;
      end else
          begin
          XStart:=0;
          XWidth:=0;
          end;
   end else
       begin
       if self.Left<=ARect.right then
          begin
          XStart:=self.left;
          XWidth:=min(ARect.right, self.right) - self.left + 1;
          end else
              begin
              XStart:=0;
              XWidth:=0;
              end;
       end;

if self.top<=ARect.top then
   begin
   if ARect.top<=self.bottom then
      begin
      YStart:=ARect.Top;
      YWidth:=min(ARect.bottom, self.bottom) - ARect.top + 1;
      end else
          begin
          YStart:=0;
          YWidth:=0;
          end;
   end else
       begin
       if self.Top<=ARect.bottom then
          begin
          YStart:=self.top;
          YWidth:=min(ARect.bottom, self.bottom) - self.top + 1;
          end else
              begin
              YStart:=0;
              YWidth:=0;
              end;
       end;

  {$ifdef EnhancedRecordSupport}
  //todo: is it possible to call constructor directly like object?
  Intersection:=T2DIntRect.create(XStart, YStart, XStart+XWidth-1, YStart+YWidth-1);
  {$else}
  Intersection.create(XStart, YStart, XStart+XWidth-1, YStart+YWidth-1);
  {$endif}
  result:=(XWidth>0) and (YWidth>0);
end;

function T2DIntRect.IntersectsWith(ARect: T2DIntRect): boolean;
begin
  result:=( max(ARect.left, self.left) <= min(ARect.right, self.right) )
        and
        ( max(ARect.Top, self.top) <= min(ARect.bottom, self.bottom) );
end;

procedure T2DIntRect.Move(dx, dy: integer);
begin
  inc(left, dx);
  inc(right, dx);
  inc(top, dy);
  inc(bottom, dy);
end;

procedure T2DIntRect.Move(AVector: T2DIntVector);
begin
  inc(self.left,AVector.x);
  inc(self.right, AVector.x);
  inc(self.top, AVector.y);
  inc(self.Bottom, AVector.y);
end;

function T2DIntRect.Moved(AVector: T2DIntVector): T2DIntRect;
begin
  result.left:=self.left+AVector.x;
  result.Right:=self.right+AVector.x;
  result.top:=self.top+AVector.y;
  result.bottom:=self.bottom+AVector.y;
end;

procedure T2DIntRect.Split(var LeftTop, RightTop, LeftBottom,
  RightBottom: T2DIntRect);
begin
if self.left = self.right then
   begin
   LeftTop.left:=self.left;
   LeftTop.right:=self.right;

   LeftBottom.left:=self.left;
   LeftBottom.right:=self.right;

   RightTop.left:=self.left;
   RightTop.right:=self.right;

   RightBottom.left:=self.left;
   RightBottom.right:=self.right;
   end else
       begin
       LeftTop.left:=self.left;
       LeftTop.right:=self.left+(self.right-self.left) div 2;

       LeftBottom.left:=self.left;
       LeftBottom.right:=self.left+(self.right-self.left) div 2;

       RightTop.left:=self.left+(self.right-self.left) div 2 + 1;
       RightTop.right:=self.right;

       RightBottom.left:=self.left+(self.right-self.left) div 2 + 1;
       RightBottom.right:=self.right;
       end;

if self.top = self.bottom then
   begin
   LeftTop.top:=self.top;
   LeftTop.bottom:=self.bottom;

   LeftBottom.top:=self.top;
   LeftBottom.bottom:=self.bottom;

   RightTop.top:=self.top;
   RightTop.bottom:=self.bottom;

   RightBottom.top:=self.top;
   RightBottom.bottom:=self.bottom;
   end else
       begin
       LeftTop.top:=self.top;
       LeftTop.bottom:=self.top+(self.bottom-self.top) div 2;

       LeftBottom.top:=self.top;
       LeftBottom.bottom:=self.top+(self.bottom-self.top) div 2;

       RightTop.top:=self.top+(self.bottom-self.top) div 2 + 1;
       RightTop.bottom:=self.bottom;

       RightBottom.top:=self.top+(self.bottom-self.top) div 2 + 1;
       RightBottom.bottom:=self.bottom;
       end;
end;

function T2DIntRect.Width: integer;
begin
  result:=self.right-self.left+1;
end;

function T2DIntRect.Moved(dx, dy: integer): T2DIntRect;
begin
  result.left:=self.left+dx;
  result.Right:=self.right+dx;
  result.top:=self.top+dy;
  result.bottom:=self.bottom+dy;
end;

function T2DIntRect.ForWinAPI: TRect;
begin
  result.left:=self.left;
  result.top:=self.top;
  result.right:=self.right+1;
  result.bottom:=self.bottom+1;
end;


{$ifdef EnhancedRecordSupport}

class operator T2DIntRect.Add(AVector: T2DIntVector;
  ARect: T2DIntRect): T2DIntRect;
begin
  result:=T2DIntRect.Create(ARect.left + AVector.x,
                          ARect.top + AVector.y,
                          ARect.Right + AVector.x,
                          ARect.bottom + AVector.y);
end;

class operator T2DIntRect.Add(ARect: T2DIntRect;
  AVector: T2DIntVector): T2DIntRect;
begin
  result:=T2DIntRect.Create(ARect.left + AVector.x,
                          ARect.top + AVector.y,
                          ARect.Right + AVector.x,
                          ARect.bottom + AVector.y);
end;

class operator T2DIntRect.Explicit(ARect: T2DIntRect): TRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DIntRect.Explicit(ARect: TRect): T2DIntRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DIntRect.Implicit(ARect: T2DIntRect): TRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DIntRect.Implicit(ARect: TRect): T2DIntRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DIntRect.Implicit(ARect: T2DIntRect): string;
begin
  result:='('+inttostr(ARect.left)+', '+inttostr(ARect.top)+', '+inttostr(ARect.right)+', '+inttostr(ARect.bottom)+')';
end;



class operator T2DIntRect.Subtract(AVector: T2DIntVector;
  ARect: T2DIntRect): T2DIntRect;
begin
result:=T2DIntRect.Create(AVector.x - ARect.left,
                          AVector.y - ARect.top,
                          AVector.x - ARect.Right,
                          AVector.y - ARect.bottom);
end;

class operator T2DIntRect.Subtract(ARect: T2DIntRect;
  AVector: T2DIntVector): T2DIntRect;
begin
result:=T2DIntRect.Create(ARect.left - AVector.x,
                          ARect.top - AVector.y,
                          ARect.Right - AVector.x,
                          ARect.bottom - AVector.y);
end;


class operator T2DIntRect.Explicit(ARect: T2DIntRect): string;
begin
result:='('+inttostr(ARect.left)+', '+inttostr(ARect.top)+', '+inttostr(ARect.right)+', '+inttostr(ARect.bottom)+')';
end;

{$endif}

{ T2DRect }

constructor T2DRect.Create(ALeft, ATop, ARight, ABottom: extended);
begin
  self.left:=ALeft;
  self.top:=ATop;
  self.right:=ARight;
  self.bottom:=ABottom;
end;

constructor T2DRect.Create(ATopLeft, ABottomRight: T2DVector);
begin
  {$ifdef EnhancedRecordSupport}
  self.TopLeft:=ATopLeft;
  self.BottomRight:=ABottomRight;
  {$else}
  Left := ATopLeft.x;
  Top := ATopLeft.y;
  Right := ABottomRight.x;
  Bottom := ABottomRight.y;
  {$endif}
end;

function T2DRect.Contains(APoint: T2DPoint): boolean;
begin
  result:=(APoint.x>=self.Left) and (APoint.y<=self.Right) and
        (APoint.y>=self.Top) and (APoint.y<=self.Bottom);
end;

procedure T2DRect.ExpandBy(APoint: T2DPoint);
begin
  self.left:=min(self.left,APoint.x);
  self.right:=max(self.right,APoint.x);
  self.top:=min(self.top,APoint.y);
  self.bottom:=max(self.bottom,APoint.y);
end;

function T2DRect.GetVertex(ACorner: TRectCorner): T2DVector;
begin
  {$ifdef EnhancedRecordSupport}
  case ACorner of
       rcLeftTop : result:=T2DVector.Create(self.left, self.top);
       rcRightTop : result:=T2DVector.Create(self.right, self.top);
       rcLeftBottom : result:=T2DVector.Create(self.left, self.bottom);
       rcRightBottom : result:=T2DVector.Create(self.right, self.bottom);
  end;
  {$else}
  case ACorner of
       rcLeftTop : result.Create(self.left, self.top);
       rcRightTop : result.Create(self.right, self.top);
       rcLeftBottom : result.Create(self.left, self.bottom);
       rcRightBottom : result.Create(self.right, self.bottom);
  end;
  {$endif}
end;

function T2DRect.Height: extended;
begin
  result:=self.bottom-self.top;
end;

function T2DRect.IntersectsWith(ARect: T2DRect): boolean;
begin
  result:=( ( (ARect.left>=self.left) and (ARect.left<=self.left) ) or
          ( (ARect.right>=self.right) and (ARect.right<=self.right) ) or
          ( (self.left>=ARect.left) and (self.left<=ARect.right) ) or
          ( (self.right>=ARect.left) and (self.right<=ARect.right) ) )
        and
        ( ( (ARect.top>=self.top) and (ARect.top<=self.top) ) or
          ( (ARect.bottom>=self.bottom) and (ARect.bottom<=self.bottom) ) or
          ( (self.top>=ARect.top) and (self.top<=ARect.bottom) ) or
          ( (self.bottom>=ARect.top) and (self.bottom<=ARect.bottom) ) );
end;

procedure T2DRect.Move(dx, dy: extended);
begin
  self.left:=self.left+dx;
  self.right:=self.right+dx;
  self.top:=self.top+dy;
  self.bottom:=self.bottom+dy;
end;

function T2DRect.Moved(dx, dy: extended): T2DRect;
begin
  result.left:=self.left+dx;
  result.right:=self.right+dx;
  result.top:=self.top+dy;
  result.bottom:=self.bottom+dy;
end;

procedure T2DRect.Move(Vector: T2DVector);
begin
  self.left:=self.left+vector.x;
  self.right:=self.right+vector.x;
  self.top:=self.top+vector.y;
  self.bottom:=self.bottom+vector.y;
end;

function T2DRect.Moved(Vector: T2DVector): T2DRect;
begin
  result.left:=self.left+Vector.x;
  result.right:=self.right+Vector.x;
  result.top:=self.top+Vector.y;
  result.bottom:=self.bottom+Vector.y;
end;

procedure T2DRect.SetCenteredHeight(ANewHeight: extended);

var center : extended;

begin
  if (ANewHeight<0) then
     raise exception.create('T2DRect.SetCenteredHeight: New height is less than zero!');
     //raise exception.create('T2DRect.SetCenteredHeight: Nowa wysokoœæ mniejsza od zera!');

  center:=self.top+(self.bottom-self.top)/2;
  self.top:=center-(ANewHeight/2);
  self.bottom:=center+(ANewHeight/2);
end;

procedure T2DRect.SetCenteredWidth(ANewWidth: extended);

var center : extended;

begin
  if (ANewWidth<0) then
     raise exception.create('T2DRect.SetCenteredWidth: New width is less than zero!');
     //raise exception.create('T2DRect.SetCenteredWidth: Nowa szerokoœæ mniejsza od zera!');

  center:=self.left+(self.right-self.left)/2;
  self.left:=center-(ANewWidth/2);
  self.right:=center+(ANewWidth/2);
end;

procedure T2DRect.Split(var LeftTop, RightTop, LeftBottom,
  RightBottom: T2DRect);
begin
  LeftTop.left:=self.left;
  LeftTop.right:=self.left+(self.right-self.left)/2;

  LeftBottom.left:=self.left;
  LeftBottom.right:=self.left+(self.right-self.left)/2;

  RightTop.left:=self.left+(self.Right-self.left)/2;
  RightTop.Right:=self.right;

  RightBottom.left:=self.left+(self.right-self.left)/2;
  RightBottom.right:=self.right;


  LeftTop.top:=self.top;
  LeftTop.bottom:=self.top+(self.bottom-self.top)/2;

  LeftBottom.top:=self.top;
  LeftBottom.bottom:=self.top+(self.bottom-self.top)/2;

  RightTop.top:=self.top+(self.bottom-self.top)/2;
  RightTop.bottom:=self.bottom;

  RightBottom.top:=self.top+(self.bottom-self.top)/2;
  RightBottom.bottom:=self.bottom;
end;

function T2DRect.Width: extended;
begin
  result:=self.right-self.left;
end;

{$ifdef EnhancedRecordSupport}

class operator T2DRect.Explicit(ARect: TRect): T2DRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DRect.Explicit(ARect: T2DRect): TRect;
begin
  result.left:=round(ARect.left);
  result.top:=round(ARect.top);
  result.Right:=round(ARect.Right);
  result.bottom:=round(ARect.bottom);
end;

class operator T2DRect.Explicit(ARect: T2DRect): T2DIntRect;
begin
  result.left:=round(ARect.left);
  result.top:=round(ARect.top);
  result.Right:=round(ARect.Right);
  result.bottom:=round(ARect.bottom);
end;

class operator T2DRect.Explicit(ARect: T2DIntRect): T2DRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DRect.Implicit(ARect: TRect): T2DRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DRect.Implicit(ARect: T2DRect): TRect;
begin
  result.left:=round(ARect.left);
  result.top:=round(ARect.top);
  result.Right:=round(ARect.Right);
  result.bottom:=round(ARect.bottom);
end;

class operator T2DRect.Implicit(ARect: T2DRect): T2DIntRect;
begin
  result.left:=round(ARect.left);
  result.top:=round(ARect.top);
  result.Right:=round(ARect.Right);
  result.bottom:=round(ARect.bottom);
end;

class operator T2DRect.Implicit(ARect: T2DIntRect): T2DRect;
begin
  result.left:=ARect.left;
  result.top:=ARect.top;
  result.Right:=ARect.Right;
  result.bottom:=ARect.bottom;
end;

class operator T2DRect.Explicit(ARect: T2DRect): string;
begin
  result:='('+floattostr(ARect.left)+', '+floattostr(ARect.top)+', '+floattostr(ARect.right)+', '+floattostr(ARect.bottom)+')';
end;

class operator T2DRect.Implicit(ARect: T2DRect): string;
begin
  result:='('+floattostr(ARect.left)+', '+floattostr(ARect.top)+', '+floattostr(ARect.right)+', '+floattostr(ARect.bottom)+')';
end;

{$endif}

procedure EnsureOrder(var a, b: Integer);
var
  tmp: Integer;
begin
  if a <= b then
     exit;
  tmp := a;
  a := b;
  b := tmp;
end;

end.
