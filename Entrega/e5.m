clear all
clc
clf

C=[0.6124310281738 2.5242056348144 1];
D=[0.8204003548175 1.9289830792479 1];
E=[2.7136383628844 0.8245942412089 1];
F=[2.7279810750667 1.3767886602284 1];
G=[4.2769939907579 3.6214231167623 1];
H=[4.1120528006611 3.0262005611958 1];
I=[2.5056690362407 4.266845164967 1];
J=[3.3734031232714 2.6676327566377 1];

C_1=[0.3007167718919 3.0019983856529 1];
D_1=[0.5475490465858 2.2563592225149 1];
E_1=[1.9925463213568 0.6313800807796 1];
F_1=[1.8742725230659 1.3410228705247 1];
G_1=[4.769409411664 3.4442395444796 1];
H_1=[4.5688581884752 2.6677463470048 1];
I_1=[2.9850177591888 4.2978678277963 1];
J_1=[3.0930068793674 2.6626040079487 1];


x1 = [C; D; E; F; G; H; I; J];
x2 = [C_1; D_1; E_1; F_1; G_1; H_1; I_1; J_1];
x = [x1;x2];

[FX, e1, e_2]=fundmatrix(x1',x2');

P = [1 0 0 0;
     0 1 0 0;
     0 0 1 0];
e_X = [0        -e_2'(1,3) e_2'(1,2);
       e_2'(1,3) 0        -e_2'(1,1);
       -e_2'(1,2) e_2'(1,1) 0];
F_x = e_X * FX;
p_1=[F_x(1,1) F_x(1,2) F_x(1,3) e_2'(1,1);
     F_x(2,1) F_x(2,2) F_x(2,3) e_2'(1,2);
     F_x(3,1) F_x(3,2) F_x(3,3) e_2'(1,3)];
     
function res = calculaPunto(x,x_1,P,P_1)
  A = [x(1)*P(3,:)-P(1,:);
       x(2)*P(3,:)-P(2,:);
       x_1(1)*P_1(3,:)-P_1(1,:);
       x_1(2)*P_1(3,:)-P_1(2,:) ];

  [U,D,V] = svd(A);
  res = V(:,end);
endfunction

## Calculamos la correccion de los puntos 
punto_1=calculaPunto (C,C_1,P,p_1);
punto_2=calculaPunto (D,D_1,P,p_1);
punto_3=calculaPunto (E,E_1,P,p_1);
punto_4=calculaPunto (F,F_1,P,p_1);
punto_5=calculaPunto (G,G_1,P,p_1);
punto_6=calculaPunto (H,H_1,P,p_1);
punto_7=calculaPunto (I,I_1,P,p_1);
punto_8=calculaPunto (J,J_1,P,p_1);

## 1 -- C
## 2 -- D
## 3 -- E
## 4 -- F
## 5 -- G
## 6 -- H
## 7 -- I
## 8 -- J

## C -- D -- E -- F
## F -- G -- H -- E
## G -- I -- C
## I -- J -- D

## 1 -- 2 -- 3 -- 4
## 4 -- 5 -- 6 -- 3
## 5 -- 7 -- 1
## 7 -- 8 -- 2

figure(1)
hold on
scatter3(punto_1(1),punto_1(2),punto_1(3));
scatter3(punto_2(1),punto_2(2),punto_2(3));
scatter3(punto_3(1),punto_3(2),punto_3(3));
scatter3(punto_4(1),punto_4(2),punto_4(3));
scatter3(punto_5(1),punto_5(2),punto_5(3));
scatter3(punto_6(1),punto_6(2),punto_6(3));
scatter3(punto_7(1),punto_7(2),punto_7(3));
scatter3(punto_8(1),punto_8(2),punto_8(3));


plot3([punto_1(1) punto_2(1)], [punto_1(2) punto_2(2)], [punto_1(3) punto_2(3)], '-');
plot3([punto_2(1) punto_3(1)], [punto_2(2) punto_3(2)], [punto_2(3) punto_3(3)], '-');
plot3([punto_3(1) punto_4(1)], [punto_3(2) punto_4(2)], [punto_3(3) punto_4(3)], '-');
plot3([punto_4(1) punto_1(1)], [punto_4(2) punto_1(2)], [punto_4(3) punto_1(3)], '-');

plot3([punto_4(1) punto_5(1)], [punto_4(2) punto_5(2)], [punto_4(3) punto_5(3)], '-');
plot3([punto_5(1) punto_6(1)], [punto_5(2) punto_6(2)], [punto_5(3) punto_6(3)], '-');
plot3([punto_6(1) punto_3(1)], [punto_6(2) punto_3(2)], [punto_6(3) punto_3(3)], '-');

plot3([punto_5(1) punto_7(1)], [punto_5(2) punto_7(2)], [punto_5(3) punto_7(3)], '-');
plot3([punto_7(1) punto_1(1)], [punto_7(2) punto_1(2)], [punto_7(3) punto_1(3)], '-');

###TENEMOS QUE 1 Y 2 ESTAN A 11 CM
##2 Y 3 A 27CM
##3 Y 4 10
##4 Y 5 A 38

# Dimensiones caja
# Alto = 11 cm
# Largo= 38 cm
# Ancho= 27 cm 
P1=punto_1;
P2=punto_2;
P3=punto_3;
P4=punto_4;
P5=punto_5;
P6=punto_6;
P7=punto_7;

P1_1=[0   0   11  0];
P2_1=[0   0   0   0];
P3_1=[27  0   0   0];
P4_1=[27  0   11  0];
P5_1=[27  38  11  0];
P6_1=[27  38  0   0];
P7_1=[0   38  11  0];

vecSol =  [P1_1(1:3)' ; P2_1(1:3)' ; P3_1(1:3)' ; P4_1(1:3)'; P5_1(1:3)'; P6_1(1:3)'; P7_1(1:3)'];
##HEMOS DESPEJADO EN PAPEL LA ECUACION Y NOS QUEDA ALGO DE ESTE TIPO
mat1_1 = [ P1(1) P1(2) P1(3) 1 0 0 0 0 0 0 0 0 P1(1)-(P1_1(1)*P1(1)) P1(2)-(P1_1(1)*P1(2)) P1(3)-(P1_1(1)*P1(3))]; 
mat1_2 = [ 0 0 0 0 P1(1) P1(2) P1(3) 1 0 0 0 0 P1(1)-(P1_1(2)*P1(1)) P1(2)-(P1_1(2)*P1(2)) P1(3)-(P1_1(2)*P1(3))]; 
mat1_3 = [ 0 0 0 0 0 0 0 0 P1(1) P1(2) P1(3) 1 P1(1)-(P1_1(3)*P1(1)) P1(2)-(P1_1(3)*P1(2)) P1(3)-(P1_1(3)*P1(3))]; 

mat2_1 = [ P2(1) P2(2) P2(3) 1 0 0 0 0 0 0 0 0 P2(1)-(P2_1(1)*P2(1)) P2(2)-(P2_1(1)*P2(2)) P2(3)-(P2_1(1)*P2(3))]; 
mat2_2 = [ 0 0 0 0 P2(1) P2(2) P2(3) 1 0 0 0 0 P2(1)-(P2_1(2)*P2(1)) P2(2)-(P2_1(2)*P2(2)) P2(3)-(P2_1(2)*P2(3))]; 
mat2_3 = [ 0 0 0 0 0 0 0 0 P2(1) P2(2) P2(3) 1 P2(1)-(P2_1(3)*P2(1)) P2(2)-(P2_1(3)*P2(2)) P2(3)-(P2_1(3)*P2(3))]; 

mat3_1 = [ P3(1) P3(2) P3(3) 1 0 0 0 0 0 0 0 0 P3(1)-(P3_1(1)*P3(1)) P3(2)-(P3_1(1)*P3(2)) P3(3)-(P3_1(1)*P3(3))]; 
mat3_2 = [ 0 0 0 0 P3(1) P3(2) P3(3) 1 0 0 0 0 P3(1)-(P3_1(2)*P3(1)) P3(2)-(P3_1(2)*P3(2)) P3(3)-(P3_1(2)*P3(3))]; 
mat3_3 = [ 0 0 0 0 0 0 0 0 P3(1) P3(2) P3(3) 1 P3(1)-(P3_1(3)*P3(1)) P3(2)-(P3_1(3)*P3(2)) P3(3)-(P3_1(3)*P3(3))];

mat4_1 = [ P4(1) P4(2) P4(3) 1 0 0 0 0 0 0 0 0 P4(1)-(P4_1(1)*P4(1)) P4(2)-(P4_1(1)*P4(2)) P4(3)-(P4_1(1)*P4(3))]; 
mat4_2 = [ 0 0 0 0 P4(1) P4(2) P4(3) 1 0 0 0 0 P4(1)-(P4_1(2)*P4(1)) P4(2)-(P4_1(2)*P4(2)) P4(3)-(P4_1(2)*P4(3))]; 
mat4_3 = [ 0 0 0 0 0 0 0 0 P4(1) P4(2) P4(3) 1 P4(1)-(P4_1(3)*P4(1)) P4(2)-(P4_1(3)*P4(2)) P4(3)-(P4_1(3)*P4(3))];

mat5_1 = [ P5(1) P5(2) P5(3) 1 0 0 0 0 0 0 0 0 P5(1)-(P5_1(1)*P5(1)) P5(2)-(P5_1(1)*P5(2)) P5(3)-(P5_1(1)*P5(3))]; 
mat5_2 = [ 0 0 0 0 P5(1) P5(2) P5(3) 1 0 0 0 0 P5(1)-(P5_1(2)*P5(1)) P5(2)-(P5_1(2)*P5(2)) P5(3)-(P5_1(2)*P5(3))]; 
mat5_3 = [ 0 0 0 0 0 0 0 0 P5(1) P5(2) P5(3) 1 P5(1)-(P5_1(3)*P5(1)) P5(2)-(P5_1(3)*P5(2)) P5(3)-(P5_1(3)*P5(3))];

mat6_1 = [ P6(1) P6(2) P6(3) 1 0 0 0 0 0 0 0 0 P6(1)-(P6_1(1)*P6(1)) P6(2)-(P6_1(1)*P6(2)) P6(3)-(P6_1(1)*P6(3))]; 
mat6_2 = [ 0 0 0 0 P6(1) P6(2) P6(3) 1 0 0 0 0 P6(1)-(P6_1(2)*P6(1)) P6(2)-(P6_1(2)*P6(2)) P6(3)-(P6_1(2)*P6(3))]; 
mat6_3 = [ 0 0 0 0 0 0 0 0 P6(1) P6(2) P6(3) 1 P6(1)-(P6_1(3)*P6(1)) P6(2)-(P6_1(3)*P6(2)) P6(3)-(P6_1(3)*P6(3))];

mat7_1 = [ P7(1) P7(2) P7(3) 1 0 0 0 0 0 0 0 0 P7(1)-(P7_1(1)*P7(1)) P7(2)-(P7_1(1)*P7(2)) P7(3)-(P7_1(1)*P7(3))]; 
mat7_2 = [ 0 0 0 0 P7(1) P7(2) P7(3) 1 0 0 0 0 P7(1)-(P7_1(2)*P7(1)) P7(2)-(P7_1(2)*P7(2)) P7(3)-(P7_1(2)*P7(3))]; 
mat7_3 = [ 0 0 0 0 0 0 0 0 P7(1) P7(2) P7(3) 1 P7(1)-(P7_1(3)*P7(1)) P7(2)-(P7_1(3)*P7(2)) P7(3)-(P7_1(3)*P7(3))];

ultimateVector = [mat1_1;mat1_2;mat1_3;
mat2_1;mat2_2;mat2_3;
mat3_1;mat3_2;mat3_3;
mat4_1;mat4_2;mat4_3;
mat5_1;mat5_2;mat5_3;
mat6_1;mat6_2;mat6_3;
mat7_1;mat7_2;mat7_3];

M = ultimateVector \ vecSol;
M = [M(1) M(2) M(3) M(4);
     M(5) M(6) M(7) M(8);
     M(9) M(10) M(11) M(12);
     M(13) M(14) M(15) 1];
     
punto_1 = M*punto_1;
punto_2 = M*punto_2;
punto_3 = M*punto_3;
punto_4 = M*punto_4;
punto_5 = M*punto_5;
punto_6 = M*punto_6;
punto_7 = M*punto_7;
punto_8 = M*punto_8;

figure(2)
hold on
scatter3(punto_1(1),punto_1(2),punto_1(3));
scatter3(punto_2(1),punto_2(2),punto_2(3));
scatter3(punto_3(1),punto_3(2),punto_3(3));
scatter3(punto_4(1),punto_4(2),punto_4(3));
scatter3(punto_5(1),punto_5(2),punto_5(3));
scatter3(punto_6(1),punto_6(2),punto_6(3));
scatter3(punto_7(1),punto_7(2),punto_7(3));
scatter3(punto_8(1),punto_8(2),punto_8(3));


plot3([punto_1(1) punto_2(1)], [punto_1(2) punto_2(2)], [punto_1(3) punto_2(3)], '-');
plot3([punto_2(1) punto_3(1)], [punto_2(2) punto_3(2)], [punto_2(3) punto_3(3)], '-');
plot3([punto_3(1) punto_4(1)], [punto_3(2) punto_4(2)], [punto_3(3) punto_4(3)], '-');
plot3([punto_4(1) punto_1(1)], [punto_4(2) punto_1(2)], [punto_4(3) punto_1(3)], '-');

plot3([punto_4(1) punto_5(1)], [punto_4(2) punto_5(2)], [punto_4(3) punto_5(3)], '-');
plot3([punto_5(1) punto_6(1)], [punto_5(2) punto_6(2)], [punto_5(3) punto_6(3)], '-');
plot3([punto_6(1) punto_3(1)], [punto_6(2) punto_3(2)], [punto_6(3) punto_3(3)], '-');

plot3([punto_5(1) punto_7(1)], [punto_5(2) punto_7(2)], [punto_5(3) punto_7(3)], '-');
plot3([punto_7(1) punto_1(1)], [punto_7(2) punto_1(2)], [punto_7(3) punto_1(3)], '-');
