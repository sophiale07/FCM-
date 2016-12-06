
% the main function

clear;
clc;


% read the image data;
%image_data=im2double(imread('tu1.bmp'));
image_data=ones(100,100);
%image_data=image_data./255;
[image_row,image_col] = size(image_data);
image_data(1:image_row,1:image_col/2)=0;
image_data(1:image_row,image_col/2+1:image_col)=255*0.8;
%image_data(1:image_row, image_col/2+1:image_col)=120;
image_data=image_data./255;
 %figure;imshow( image_data,'Border','tight');
 %imwrite(image_data,'2g.jpg');
 W=imnoise(image_data,'gaussian',0.15);%%
 W1=imnoise(image_data,'gaussian',0.08);%%
 W2=imnoise(image_data,'gaussian',0.10);%%
 imwrite(W,'15g.jpg');
  imwrite(W1,'8g.jpg');
   imwrite(W2,'10g.jpg');
%figure; imshow(Y,'Border','tight');
V=imnoise(image_data,'salt & pepper',0.15);
V1=imnoise(image_data,'salt & pepper',0.08);
V2=imnoise(image_data,'salt & pepper',0.10);
imwrite(V,'15sp.jpg');
imshow(V);
imwrite(V1,'8sp.jpg');
   imwrite(V2,'10sp.jpg');
%figure; imshow(Z,'2sp','tight');