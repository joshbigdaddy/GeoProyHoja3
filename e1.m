clear all
clc
clf

img = imread("FachadaLQ.jpg");
subplot(1,2,1);
imshow(img);

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
imshow(uint8(rimg));