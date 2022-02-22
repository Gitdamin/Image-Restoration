%% DSP_Term project
% 2. restore blurred image

% tofloat.m/ lpfilter.m/dftuv.m files are referenced data in
% https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=iyeti&logNo=2691817
% https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=bruno_annie&logNo=220772538915

%% Blurring/ Deblurring + PSF

img = imread('im1.png');
figure
imshow(img, [])
title('Origin Image')

len = 15;
theta = 45;
PSF = fspecial('motion',len, theta);
img = im2double(img);
blurred = imfilter(img,PSF,'conv','circular');
figure
imshow(blurred)
title('Blurred Image')

recovery = deconvwnr(blurred, PSF);
figure
imshow(recovery, [])
title('Restored Image')

%% FFT & IFFT + LPF

clear all; 
close all; clc
img = imread('im1_kernel1_img.png');
figure
imshow(img, [])
title('Blurred Image')

[M,N]=size(img);
[f, revertclass]=tofloat(img);
F=fft2(f);
H=lpfilter('btw',M,N,15);
H2=lpfilter('btw',M,N,35);
G=(F./H).*H2;
% G=F./H;
g=abs(ifft2(G));
g=revertclass(g);
figure
imshow(mat2gray(g))
title('Deblurred Img')

%% FFT & IFFT + Limit dev.

clear all; 
close all; clc
img=imread('im1_kernel1_img.png');
imshow(img)
title('Blurred Img')
d=0.01;
[M,N]=size(img);
[f, revertclass]=tofloat(img);
F=fft2(f);
H=lpfilter('btw',M,N,40);
H(find(H<d))=1;
G=F./H;
g=abs(ifft2(G));
g=revertclass(g);
figure
imshow(mat2gray(g))
title('Limit Dev. Deblurring')

%% Image Sharpen

clear all; 
close all; clc
origin = imread('im1_kernel1_img.png');
imshow(origin)
title('Blurred Img')
sh1 = imsharpen(origin);
figure, imshow(sh1)
title('Sharpened Image');
sh2=imsharpen(origin,'Radius',2,'Amount',1.8);
figure, imshow(sh2)
title('Sharpened Image2');

%% Emphasize Edge

clear all; 
close all; clc
origin = imread('im1_kernel1_img.png');
imshow(origin)
title('Blurred Img')
mask=[-1,-1,-1;-1,8.8,-1;-1,-1,-1]; 
G=imfilter(origin, mask);
figure
imshow(G)
title('Emphasize Edge')
