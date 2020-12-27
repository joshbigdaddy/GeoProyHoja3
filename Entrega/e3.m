clear all
clc
clf

I = imread ("./img/Esquina2.jpg");

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
tn1 = cross(cross(t1,u),l_2);
tn1 = tn1/tn1(end);
num_t1 = norm(tn1-b2);
num_t2 = norm(t2-b2);
num_v = norm(v-b2);

d2 = 1.75;
##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1 * (num_t2-num_v);
a2 = num_t2 * (num_t1-num_v);
d1 = d2 * (a1/a2);

printf("La altura del edificio es de %fm\n",d1);


% AHORA VAMOS CON EL RESTO

% MUJER
b1 = [1778 3246 1]; t1 = [1778 3082 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2);
tn1 = tn1/tn1(end);
num_t1= norm(tn1-b2);
num_t2= norm(t2-b2);
num_v = norm(v-b2);

##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1 * (num_t2-num_v);
a2 = num_t2 * (num_t1-num_v);
d1 = d2 * (a1/a2);

printf("La altura de la mujer es de %fm\n",d1);

#semaforo
b1 = [2086 2967 1]; t1 = [2086 2739 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2);
tn1 = tn1/tn1(end);
num_t1 = norm(tn1-b2);
num_t2 = norm(t2-b2);
num_v = norm(v-b2);

##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1*(num_t2-num_v);
a2 = num_t2*(num_t1-num_v);
d1 = d2 *(a1/a2);

printf("La altura del semaforo es de %fm\n",d1);


#contenedor de vidirio
b1 = [1561 2900 1]; t1 = [1561 2773 1];
b2 = [1536.7 3312.5 1]; t2 = [1535.2 3118.4 1];

v = cross(cross(b1,t1),cross(b2,t2));
v = v/v(end);
l = cross(ph,pv);

u = cross(cross(b1,b2),l);
l_2 = cross(v,b2);
tn1 = cross(cross(t1,u),l_2);
tn1 = tn1/tn1(end);
num_t1 = norm(tn1-b2);
num_t2 = norm(t2-b2);
num_v = norm(v-b2);

##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1 * (num_t2-num_v);
a2 = num_t2 * (num_t1-num_v);
d1 = d2 * (a1/a2);

printf("La altura del contenedor de vidirio es de %fm\n",d1);

## Que pasaria si elegimos otros puntos para calcular el punto de fuga?
## copiamos la parte del edificio con otros puntos de inicio
I = imread ("./img/Esquina2.jpg");

## Paso de cebra por ejemplo
h1=[2023 3492 1]; h2=[2444 3615 1];
h3=[2307 3350 1]; h4=[2817 3451 1];

##Los mismos pero mirando en la direccion perpendicular
v1=[2023 3492 1]; v3=[2444 3615 1];
v2=[2307 3350 1]; v4=[2817 3451 1];

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
tn1 = cross(cross(t1,u),l_2);
tn1 = tn1/tn1(end);
num_t1 = norm(tn1-b2);
num_t2 = norm(t2-b2);
num_v = norm(v-b2);

##los vectores pasan a ser la norma del vector - b2 
a1 = num_t1 * (num_t2-num_v);
a2 = num_t2 * (num_t1-num_v);
d1 = d2 * (a1/a2);

printf("La altura del edificio calculada con otros puntos de fuga es de %fm\n",d1);

### podemos ver que nos ha cambiado el signo a la hora del calculo porque seguramente hemos calculado 
## los puntos de una recta de fuga del reves y es posible que por eso el num_v nos haya salido tan grande
