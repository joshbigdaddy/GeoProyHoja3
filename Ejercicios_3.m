##Ejercicio 1 ################################################################
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
###############################################################################
#Ejercicio 2 


I = imread ("Calibra2.jpg");

imshow(I);

## Obtenemos los puntos de cada uno de los cuadrados
C1P1 = [806 280];
C1P2 = [620 985];
C1P3 = [1343 1057];
C1P4 = [1626 448];
C1 = [C1P1; C1P2; C1P3; C1P4];

C2P1 = [634 1469];
C2P2 = [730 2236];
C2P3 = [1540 2068];
C2P4 = [1343 1354];
C2 = [C2P1; C2P2; C2P3; C2P4];

C3P1 = [1544 855];
C3P2 = [1490 1656];
C3P3 = [2033 1871];
C3P4 = [2100 817];
C3 = [C3P1; C3P2; C3P3; C3P4];


## Calculamos las homografías
VP1 = [0 0];
VP2 = [27 0];
VP3 = [27 27];
VP4 = [0 27];
V = [VP1; VP2; VP3; VP4];

H1 = getHomografia(V, C1);
H1A = H1 * [1 i 0]';
H1B = H1 * [1 -i 0]';

H2 = getHomografia(V, C2);
H2A = H2 * [1 i 0]';
H2B = H2 * [1 -i 0]';

H3 = getHomografia(V, C3);
H3A = H3 * [1 i 0]';
H3B = H3 * [1 -i 0]';

## Calculamos la matriz W 
h1R = real(H1A);
h1I = imag(H1A);

W11 = [(h1I(1) * h1R(1)) 
      (h1I(1) * h1R(2) + h1I(2) * h1R(1)) 
      (h1I(1) * h1R(3) + h1R(1) * h1I(3)) 
      (h1I(2) * h1R(2)) 
      (h1I(2) * h1R(3) + h1I(3) * h1R(2)) 
      (h1R(3) * h1I(3))]';
      
W12 = [(h1R(1) * h1R(1) - h1I(1) * h1I(1)) 
      ((h1R(1) * h1R(2) + h1R(2) * h1R(1)) - (h1I(1) * h1I(2) + h1I(2) * h1I(1))) 
      ((h1R(1) * h1R(3) + h1R(1) * h1R(3)) - (h1I(1) * h1I(3) + h1I(1) * h1I(3))) 
      (h1R(2) * h1R(2) - h1I(2) * h1I(2)) 
      ((h1R(2) * h1R(3) + h1R(3) * h1R(2)) - (h1I(2) * h1I(3) + h1I(3) * h1I(2))) 
      (h1R(3) * h1R(3) - h1I(3) * h1I(3))]';


h2R = real(H2A);
h2I = imag(H2A);

W21 = [(h2I(1) * h2R(1)) 
      (h2I(1) * h2R(2) + h2I(2) * h2R(1)) 
      (h2I(1) * h2R(3) + h2R(1) * h2I(3)) 
      (h2I(2) * h2R(2)) 
      (h2I(2) * h2R(3) + h2I(3) * h2R(2)) 
      (h2R(3) * h2I(3))]';

W22 = [(h2R(1) * h2R(1) - h2I(1) * h2I(1)) 
      ((h2R(1) * h2R(2) + h2R(2) * h2R(1)) - (h2I(1) * h2I(2) + h2I(2) * h2I(1))) 
      ((h2R(1) * h2R(3) + h2R(1) * h2R(3)) - (h2I(1) * h2I(3) + h2I(1) * h2I(3))) 
      (h2R(2) * h2R(2) - h2I(2) * h2I(2)) 
      ((h2R(2) * h2R(3) + h2R(3) * h2R(2)) - (h2I(2) * h2I(3) + h2I(3) * h2I(2))) 
      (h2R(3) * h2R(3) - h2I(3) * h2I(3))]';


h3R = real(H3A);
h3I = imag(H3A);

W31 = [(h3I(1) * h3R(1)) 
      (h3I(1) * h3R(2) + h3I(2) * h3R(1)) 
      (h3I(1) * h3R(3) + h3R(1) * h3I(3)) 
      (h3I(2) * h3R(2)) 
      (h3I(2) * h3R(3) + h3I(3) * h3R(2)) 
      (h3R(3) * h3I(3))]';

W32 = [(h3R(1) * h3R(1) - h3I(1) * h3I(1)) 
      ((h3R(1) * h3R(2) + h3R(2) * h3R(1)) - (h3I(1) * h3I(2) + h3I(2) * h3I(1))) 
      ((h3R(1) * h3R(3) + h3R(1) * h3R(3)) - (h3I(1) * h3I(3) + h3I(1) * h3I(3))) 
      (h3R(2) * h3R(2) - h3I(2) * h3I(2)) 
      ((h3R(2) * h3R(3) + h3R(3) * h3R(2)) - (h3I(2) * h3I(3) + h3I(3) * h3I(2))) 
      (h3R(3) * h3R(3) - h3I(3) * h3I(3))]';
      

WR = [W11;W12;W21;W22;W31;W32];

[U,D,V] = svd(WR);

x = V(:,end);

W = x/x(end);

W = [W(1) W(2) W(3); W(2) W(4) W(5); W(3) W(5) W(6)];

## Calculamos la matriz de camara K a partir de la factorización de Cholesky
K = chol(inv(W))



###############################################################################
##Ejercicio 3

I = imread ("Esquina2.jpg");

h1 = [962.17 3480 1]; h2 = [1317.91 3357.5 1];
h3 = [1113 3731.2 1]; h4 = [1476.26 3572.9 1];

v1 = [1300.07 3398.9 1]; v2 = [1492.99 3456.9 1];
v3 = [1354.71 3391.15 1]; v4 = [1514.18 3438.0 1];
imshow(I);
hold on;
points = [h3;h4];
plot(points'(1,:), points'(2,:),'o');

rh1 = cross(h1,h2); # Recta que pasa por h1 y h2
rh2 = cross(h3,h4); # Recta que pasa por h3 y h4
ph = cross(rh1,rh2);

rv1 = cross(v1,v2); # Recta que pasa por v1 y v2
rv2 = cross(v3,v4); # Recta que pasa por v3 y v4
pv = cross(rv1, rv2);

% t1 punto arriba edificio 
% t2 punto arriba señor
% b1 punto abajo edificio 
% b2 punto abajo señor
% v producto cruzado de las rectas  que unen al señor y al edificio
% l distancia entre los puntos de fuga que forman la acera y las líneas

b1 = [3343.5 1366.4 1]; t1 = [450.71 1346.1 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2)
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2)
num_t2= norm(t2-b2)
num_v = norm(v-b2)

d2 = 1.75;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v)
a2=num_t2*(num_t1-num_v)
d1 = d2 *(a1/a2)


% AHORA VAMOS CON EL RESTO

% MUJER
b1 = [1778 3246 1]; t1 = [1778 3082 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2)
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2)
num_t2= norm(t2-b2)
num_v = norm(v-b2)

d1 = 175;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v)
a2=num_t2*(num_t1-num_v)
d1 = d2 *(a1/a2)

#semaforo
b1 = [2086 2967 1]; t1 = [2086 2739 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2)
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2)
num_t2= norm(t2-b2)
num_v = norm(v-b2)

d2 = 175;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v)
a2=num_t2*(num_t1-num_v)
d1 = d2 *(a1/a2)

#contenedor de vidirio
b1 = [1561 2900 1]; t1 = [1561 2773 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2)
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2)
num_t2= norm(t2-b2)
num_v = norm(v-b2)

d2 = 175;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v)
a2=num_t2*(num_t1-num_v)
d1 = d2 *(a1/a2)

## Que pasaria si elegimos otros puntos para calcular el punto de fuga?
## copiamos la parte del edificio con otros puntos de inicio

I = imread ("Esquina2.jpg");

## Paso de cebra por ejemplo

h1=[2023 3492 1];
h2=[2444 3615 1];
h3=[2307 3350 1];
h4=[2817 3451 1];

##Los mismos pero mirando en la direccion perpendicular
v1=[2023 3492 1];
v3=[2444 3615 1];
v2=[2307 3350 1];
v4=[2817 3451 1];
imshow(I);
hold on;
points = [h1;h2;h3;h4;v1;v2;v3;v4];
plot(points'(1,:), points'(2,:),'o');

rh1 = cross(h1,h2); # Recta que pasa por h1 y h2
rh2 = cross(h3,h4); # Recta que pasa por h3 y h4
ph = cross(rh1,rh2);

rv1 = cross(v1,v2); # Recta que pasa por v1 y v2
rv2 = cross(v3,v4); # Recta que pasa por v3 y v4
pv = cross(rv1, rv2);

% t1 punto arriba edificio 
% t2 punto arriba señor
% b1 punto abajo edificio 
% b2 punto abajo señor
% v producto cruzado de las rectas  que unen al señor y al edificio
% l distancia entre los puntos de fuga que forman la acera y las líneas

b1 = [3343.5 1366.4 1]; t1 = [450.71 1346.1 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2)
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2)
num_t2= norm(t2-b2)
num_v = norm(v-b2)

d2 = 1.75;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v)
a2=num_t2*(num_t1-num_v)
d1 = d2 *(a1/a2)

### podemos ver que nos ha cambiado el signo a la hora del calculo porque seguramente hemos calculado 
## los puntos de una recta de fuga del reves y es posible que por eso el num_v nos haya salido tan grande

###########################################################################
##Ejercicio 4 -- Homografias

## 1. Cargamos las imagenes

img_centro = imread ("Berserk_centro.png");
img_izda = imread ("Berserk_izquierda.png");
img_dcha = imread ("Berserk_derecha.png");


## 2. Ampliamos el tamaño de las imagenes

f = rows(img_centro);
c = columns(img_centro);

size(img_centro);

img_centro = [zeros(f,c) img_centro zeros(f,c)];
img_izda = [img_izda zeros(f,c) zeros(f,c)];
img_dcha = [zeros(f,c) zeros(f,c) img_dcha];


## 3. Obtenemos los puntos de referencia de las imagenes

%puntos imagen centro
C1_iz = [340 796]; %interior arriba
C2_iz = [340 761]; %exterior arriba
C3_iz = [710 795]; %interior abajo
C4_iz = [710 760]; %exterior abajo

C1_dcha=[337 1460]; %interior arriba
C2_dcha=[337 1485]; %exterior arriba
C3_dcha=[713 1461]; %interior abajo
C4_dcha=[713 1494]; %exterior abajo

C_IZ = [C1_iz;C2_iz;C3_iz;C4_iz];
C_DCHA = [C1_dcha;C2_dcha;C3_dcha;C4_dcha];

%puntos imagen derecha
D1_dcha=[367 1889]; %interior arriba
D2_dcha=[369 1917]; %exterior arriba
D3_dcha=[697 1901]; %interior abajo
D4_dcha=[691 1930]; %exterior abajo

D_DCHA = [D1_dcha;D2_dcha;D3_dcha;D4_dcha];

%puntos imagen izquierda
I1_iz = [360 442]; %interior arriba
I2_iz = [360 414]; %exterior arriba
I3_iz = [690 409]; %interior abajo
I4_iz = [682 382]; %exterior abajo

I_IZ = [I1_iz;I2_iz;I3_iz;I4_iz];

## 4. Calculamos y aplicamos las homografías

H_D = getHomografia(C_DCHA,D_DCHA);
H_I = getHomografia(C_IZ, I_IZ);

% IZQUIERDA
f = rows(img_izda);
c = columns(img_izda);

I_IMG = zeros(f,c);

for i = 1:f
    for j = 1:c
      r = H_I * [i, j, 1]';
      r = r / r(end);
      x = round(r(1));
      y = round(r(2));
      if (x>0 && y>0 && x<=f && y<=c)
        I_IMG(i,j) = img_izda(x,y);
      endif
    endfor
endfor


% DERECHA
f = rows(img_dcha);
c = columns(img_dcha);

D_IMG = zeros(f,c);

for i = 1:f
    for j = 1:c
      r = H_D * [i, j, 1]';
      r = r / r(end);
      x = round(r(1));
      y = round(r(2));
      if (x>0 && y>0 && x<=f && y<=c)
        D_IMG(i,j) = img_dcha(x,y);
      endif
    endfor
endfor


## 4. Recorremos las imagenes para pintarlas en su posición

f = rows(img_centro);
c = columns(img_centro);

for i = 1:f
    for j = 1:c
      if(img_centro(i,j) == 0)
        if(j < c/2)
          img_centro(i,j) = I_IMG(i,j);
        else 
          img_centro(i,j) = D_IMG(i,j);
        endif
      endif 
    endfor
endfor

## 5. Pintamos la imagen resultante

imshow(uint8(img_centro));

######################################################################################################
##EJ5 ################################################################################################

C=[0.6124310281738 2.5242056348144 1];
D=[0.8204003548175 1.9289830792479 1];
E=[2.7136383628844 0.8245942412089 1];
F=[2.7279810750667 1.3767886602284 1];
G=[4.2769939907579 3.6214231167623 1];
H=[4.1120528006611 3.0262005611958 1];
I=[2.5056690362407 4.266845164967  1];
J=[3.3734031232714 2.6676327566377 1];

C_1=[1.8742725230659 1.3410228705247 1];
D_1=[0.3007167718919 3.0019983856529 1];
E_1=[4.769409411664 3.4442395444796  1];
F_1=[2.9850177591888 4.2978678277963 1];
G_1=[1.9925463213568 0.6313800807796 1];
H_1=[4.5688581884752 2.6677463470048 1];
I_1=[0.5475490465858 2.2563592225149 1];
J_1=[3.0930068793674 2.6626040079487 1];

x1 = [C; D; E; F; G; H; I; J];
x2 = [C_1; D_1; E_1; F_1; G_1; H_1; I_1; J_1];
x = [x1;x2];

[F, e1, e_2]=fundmatrix(x1',x2');

P = [1 0 0 0;
     0 1 0 0;
     0 0 1 0];
e_X = [0        -e_2'(1,3) e_2'(1,2);
       e_2'(1,3) 0        -e_2'(1,1);
       -e_2'(1,2) e_2'(1,1) 0];
F_x = e_X * F;
p_1=[F_x(1,1) F_x(1,2) F_x(1,3) e_2'(1,1);
     F_x(2,1) F_x(2,2) F_x(2,3) e_2'(1,2);
     F_x(3,1) F_x(3,2) F_x(3,3) e_2'(1,3);]

function res = calculaPunto(x,x_1,P,P_1)

A = [x(1,1)*P(3,:)-P(1,:);
     x(1,2)*P(3,:)-P(2,:);
     x_1(1,1)*P_1(3,:)-P_1(1,:);
     x_1(1,2)*P_1(3,:)-P_1(2,:) ];

     
 [U,D,V] = svd(A);
  res = V(:,end);
endfunction

## Calculamos la correccion de los puntos 
punto_1=calculaPunto (C,C_1,P,p_1)
%p1_rect = punto_1/punto_1(end);

punto_2=calculaPunto (D,D_1,P,p_1)
%p2_rect = punto_2/punto_2(end);

punto_3=calculaPunto (E,E_1,P,p_1)
%p3_rect = punto_3/punto_3(end);

punto_4=calculaPunto (F,F_1,P,p_1)
%p4_rect = punto_4/punto_4(end);

punto_5=calculaPunto (G,G_1,P,p_1);
%p5_rect = punto_5/punto_5(end);

punto_6=calculaPunto (H,H_1,P,p_1)
%p6_rect = punto_6/punto_6(end);

punto_7=calculaPunto (I,I_1,P,p_1)
%p7_rect = punto_7/punto_7(end);

punto_8=calculaPunto (J,J_1,P,p_1)
%p8_rect = punto_8/punto_8(end);

###TENEMOS QUE 1 Y 2 ESTAN A 10 CM
##2 Y 3 A 27CM
##3 Y 4 10
##4 Y 5 A 38

P1=[];
P2=[];
P3=[];
P4=[];
P5=[];



