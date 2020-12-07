##Ejercicio 1
img = imread ("FachadaLQ.jpg");

p1=[166 174];
p2=[166 212];
p3=[212  212];
p4=[212 174];## al reves
subplot(1,2,1);
imshow(img);
hold on
points=[p1; p2; p3; p4]
hold on
plot(points'(1,:), points'(2,:),'o')
plot(points'(3,:), points'(4,:),'o')
plot(points'(5,:), points'(6,:),'o')
plot(points'(7,:), points'(8,:),'o')
xlabel ("x");
ylabel ("y");
zlabel ("z");
axis equal
## 1 y 2 tienen que medir entre ellos 2,5m
## 3 y 4 lo mismo
## 1 y 3 tienen que medir 1.5m
## 2 y 4 tienen que medir lo mismo 

norm(p1-p2)
norm(p3-p4)
##Nuestros nuevos puntos van a ser
#1,5m --> 50 pixels
#2,5m --> x
proporcion=(2.5*50)/1.5
p1_2=[ 150 200]
p2_2=[ 150 283]
p3_2=[200 200]
p4_2=[ 200 283]

function h = getHomografia(p1,p2)
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
points2=[p1_2; p2_2; p3_2; p4_2]

P1=[166 175];
P2=[164 213];
P3=[213 175];
P4=[217 212];

PI=[P1;P2;P3;P4];

PT1=[166 128];
PT2=[166 213];
PT3=[217 128];
PT4=[217 213];

PTI=[PT1;PT2;PT3;PT4];

h = getHomografia(PTI,PI);
#h = getHomografia(points,points2);

f = rows(img);
c = columns(img);

rimg = [];

for i = 1:f
    for j = 1:c
      r = h * [i, j, 1]';
      r = r / r(end);
      x = round(r(1));
      y = round(r(2));
      if (x>0 && y>0 && x<=f && y<=c)
        rimg(i,j) = img(x,y);
      endif
    endfor
endfor

subplot(1,2,2);
imshow(uint8(rimg))

##Ejercicio 3
h1 = [962.17 3480 1];h2 = [1317.91 3357.5 1];
h3 = [1113 3731.2 1];h4 = [1476.26 3572.9 1];
v1 = [1300.07 3398.9 1];v2 = [1492.99 3456.9 1];
v3 = [1354.71 3391.15 1];v4 = [1514.18 3438.0 1];
I = imread ("Esquina2.jpg");
points = [h1; h2; h3; h4; v1; v2; v3; v4];
rh1 = cross(h1,h2); # Recta que pasa por h1 y h2
imshow(I)
hold on
plot(points'(1,:), points'(2,:),'o')
hold on
plot(x,(-rh1(1)*x-rh1(3))/rh1(2),'b')
xlim([0,a]);
ylim([0,b])

##Ejercicio 4 -- Homografias
img_centro = imread ("Berserk_centro.jfif");
img_izda = imread ("Berserk_izquierda.jfif");
img_dcha = imread ("Berserk_derecha.jfif");


subplot(1,3,1);
hold on
imshow(img_izda);
subplot(1,3,2);
imshow(img_centro);
subplot(1,3,3);
imshow(img_dcha);

##Tienen que ir del rev�s
%puntos imagen centro
punto_1 = [681 95];%marco interior izdo arriba
punto_2 = [681 27];%marco exterior izdo arriba
punto_3 = [1418 90];%marco interior izdo abajo
punto_4 = [1418 14];%marco exterior izdo abajo
%puntos imagen centro
punto_3_dcha=[1421 1421]; %interior abajo
punto_4_dcha=[1421 1488]; %exterior abajo
punto_1_dcha=[678 1418]; %inter arriba
punto_2_dcha=[678 1488]; %exter arriba
puntos_centro_1 = [punto_1;punto_2;punto_3;punto_4];
puntos_centro_2 = [punto_1_dcha;punto_2_dcha;punto_3_dcha;punto_4_dcha];

%puntos imagen izda -- vamos a tomar de referencia los puntos de la izquierda, 
%para que as� concuerden origenes
punto_1_iz = [717 873];%int arriba
punto_2_iz = [717 823];%ext arriba
punto_3_iz = [1376 816];%int abajo
punto_4_iz = [1374 764];%ext abajo

puntos_izquierda = [punto_1_iz;punto_2_iz;punto_3_iz;punto_4_iz];

%puntos de la imagen de la dcha
punto_1_dcha = [733 780];%int arriba
punto_2_dcha = [738 832];%ext arriba
punto_3_dcha = [1397 808];%int abajo
punto_4_dcha = [1392 858];%ext abajo

puntos_dcha= [punto_1_dcha;punto_2_dcha;punto_3_dcha;punto_4_dcha];


h_izda = getHomografia(puntos_centro_1,puntos_izquierda)
h_dcha = getHomografia(puntos_centro_2,puntos_dcha)


f = rows(img_izda);
c = columns(img_izda);

rimg_izda = [];

for i = 1:f
    for j = 1:c
      r = h_izda * [i, j, 1]';
      r = r / r(end);
      x = round(r(1));
      y = round(r(2));
      if (x>0 && y>0 && x<=f && y<=c)
        rimg_izda(i,j) = img_izda(x,y);
      endif
    endfor
endfor


f = rows(img_dcha);
c = columns(img_dcha);

rimg_dcha= [];

for i = 1:f
    for j = 1:c
      r = h_dcha * [i, j, 1]';
      r = r / r(end);
      x = round(r(1));
      y = round(r(2));
      if (x>0 && y>0 && x<=f && y<=c)
        rimg_dcha(i,j) = img_dcha(x,y);
      endif
    endfor
endfor

subplot(1,3,1);
hold on
imshow(uint8(rimg_izda));
subplot(1,3,2);
imshow(img_centro);
subplot(1,3,3);
imshow(uint8(rimg_dcha));