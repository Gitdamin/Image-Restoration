%% DSP_Term project
% 1. restore noisy image

%% LPF & Median

% LPF
clear all; 
close all;
origin = imread('im1.png');
title('Origin Image')
% gray = rgb2gray(origin);
n=imnoise(origin,'salt & pepper');
imshow(n)
title('salt & pepper noise')
f3=fspecial('average');
img=filter2(f3, n);
figure
imshow(img/255)
title('3*3 LPF')
f7=fspecial('average', [7,7]);
img2=filter2(f7, n);
figure
imshow(img2/255)
title('7*7 LPF')

% Median F. 
n2=imnoise(origin,'salt & pepper', 0.2); 
figure
imshow(n2)
m=medfilt2(n2);
figure; imshow(m)
title('3*3 Median F')
m2=medfilt2(m);
figure; imshow(m2)
title('3*3 Median F2')
m5=medfilt2(n2, [5,5]);
figure; imshow(m5)
title('5*5 Median F')

%% Rank order Filter

clear all; 
close all; clc
origin = imread('im1.png');
% gray = rgb2gray(origin);
n=imnoise(origin,'salt & pepper');
ord3=ordfilt2(n, 3, [0,1,0;1,1,1;0,1,0]);
ord5=ordfilt2(n, 3, [0,0,1,0,0;0,0,1,0,0;1,1,1,1,1;0,0,1,0,0;0,0,1,0,0]);
imshow(n)
title('salt & pepper noise')
figure, imshow(ord3)
title('3*3 Rank order F')
figure, imshow(ord5)
title('5*5 Rank order F')
