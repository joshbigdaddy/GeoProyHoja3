
function h = homografia(p1,p2)
  A = [];
  b = [];
  
  for i = 1:rows(p1)
    A = [p1(i,1) p1(i,2) 1 0 0 0 -p1(i,1)*p2(i,1) -p1(i,2)*p2(i,1);
         0 0 0 p1(i,1) p1(i,2) 1 -p1(i,1)*p2(i,2) -p1(i,2)*p2(i,2);
         A];
    b = [p2(i,1);p2(i,2);b];
  endfor
  
  r = A\b;
  
  h = [r(1) r(2) r(3);r(4) r(5) r(6); r(7) r(8) 1];
endfunction 