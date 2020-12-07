
% Funcion que calcula la matriz
% de homografias con una serie de puntos xi xi' dados
function H = homografia(puntos1, puntos2)
  num_points = size(puntos1, 2);
  MH = zeros(num_points*2);
  Mb = zeros(num_points*2,1);
  counter = 1;
  
  for i=1:num_points
    p1 = puntos1(:,i);
    p1n = puntos2(:, i);
    Matec = [p1(1) p1(2) 1 0 0 0 -p1(1)*p1n(1) -p1(2)*p1n(1);
         0       0   0 p1(1) p1(2) 1 -p1(1)*p1n(2) -p1(2)*p1n(2)];
    h = [p1n(1) p1n(2)];
    
    %Seteamos los valores en MH
    MH(counter,1:end) = Matec(1,1:end);
    MH(counter+1,1:end) = Matec(2,1:end);
    
    % Seteamos los valores en Mb
    Mb(counter) = h(1);
    Mb(counter+1) = h(2);
    
    % Aumentamos el contador
    counter = counter + 2;
  endfor
  
  % Resolvemos el sistema
  sol = linsolve(MH, Mb);
  
  % Lo devolvemos como matriz
  H = [sol(1), sol(2), sol(3);
       sol(4), sol(5), sol(6);
       sol(7), sol(8), 1];

endfunction
