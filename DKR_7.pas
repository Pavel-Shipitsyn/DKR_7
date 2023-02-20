uses graphwpf;
var painting := false;
var level := 1;
var(x0,y0):=(Window.Width/3,Window.Height-Window.Height/3);
var(x1,y1):=(Window.Width-Window.Width/3,Window.Height-Window.Height/3);
procedure levi(l:integer;x0,y0,x1,y1:real);
begin
  if l>0 then begin var(x,y):=((x0+x1)/2+(y1-y0)/2,(y0+y1)/2-(x1-x0)/2);
  levi(l-1,x0,y0,x,y);levi(l-1,x,y,x1,y1) end else line(x0,y0,x1,y1);
end;
procedure drawlevi;
begin
  levi(level,x0,y0,x1,y1);
end;
procedure keyDown(k:key);
begin
  if not painting then begin
  painting := true;
  case k of
    key.Add,key.OemPlus : level+=1;
    key.Subtract,key.OemMinus : if level>1 then level-=1;
    key.W : (y0,y1):=(y0-10,y1-10);
    key.S : (y0,y1):=(y0+10,y1+10);
    key.A : (x0,x1):=(x0-10,x1-10);
    key.D : (x0,x1):=(x0+10,x1+10);
    key.Q : (x0,y0,x1,y1):=((x0-window.Center.X)*0.9+window.Center.x,(y0-window.
    Center.y)*0.9+window.Center.y,(x1-window.Center.X)*0.9+window.Center.x,(y0-
    window.Center.y)*0.9+window.Center.y);
    key.E : (x0,y0,x1,y1):=((x0-window.Center.X)*1.1+window.Center.x,(y0-window.
    Center.y)*1.1+window.Center.y,(x1-window.Center.X)*1.1+window.Center.x,(y0-
    window.Center.y)*1.1+window.Center.y);
  else
    window.Caption := $'key = {k}';
    painting := false;
    exit;
  end;
  window.Caption:='идёт построение. подождите...';
  window.Clear;
  levi(level,x0,y0,x1,y1); painting := false;
  window.Caption:='Кривая Леви '+level+'    +/- - порядок  WASD - сдвинуть  Q/E - дальше/ближе';
  end;
end;
begin
  drawlevi;
  OnKeyDown:=keyDown;
end.