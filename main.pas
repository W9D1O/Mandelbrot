program mandelbrot;

uses
  raylib,uComplex;
const
  alto = 600;
  ancho = 800;
function cumple(x,y:integer):boolean;
var
  fx,fy,y_c,x_c:real;
  c_r,c_i,nx,ny,mayor:real;
  j:integer;
begin
  mayor:= 4;
  cumple := True;
  y_c := alto div 2;
  x_c := ancho div 2;
  fx:= (x - x_c)/(ancho/6);
  fy:= (y - y_c)/(alto/4);
  c_r:= 0;
  c_i:= 0;
  for j:= 0 to 550 do begin
    nx:= sqr(c_r) - sqr(c_i) + fx;
    ny:= 2*c_r*c_i + fy;
    c_r:= nx;
    c_i:= ny;
    if ((sqr(nx) + sqr(ny)) > mayor) then begin
      cumple:= False;
      break;
    end;
  end;

end;
procedure render(var cam:TCamera2D);
var
  y,x:integer;
begin
  for y:= 0 to alto  do begin
    for x:= 0 to ancho  do
      if cumple(x,y) then
      DrawRectangle(x*1,y*1,1,1,GetColor($181818AA));
  end;
end;

{Formula: Zn+1 =Z^2n+C}
var
  cam:TCamera2D;
begin
  cam.offset.x:= 0;
  cam.offset.y:= 0;
  cam.zoom:= 1.0;
  SetTargetFPS(60);
  InitWindow(ancho,alto,'Mandelbrot');
  while not WindowShouldClose() do begin
    BeginDrawing();
    BeginMode2D(cam);

    ClearBackground(WHITE);
    
    if IsKeyDown(Key_Z)then
      cam.zoom:= cam.zoom + 0.1;
    if IsKeyDown(KEY_X)then
      cam.zoom:= cam.zoom - 0.1;
    if IsKeyDown(KEY_SPACE)then
      cam.target:=GetMousePosition();
    render(cam);
    EndMode2D();
    EndDrawing();
  end;
  end.
