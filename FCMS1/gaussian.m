X=imread('33.bmp');
Y=imnoise(X,'gaussian',0.01);%%
figure; imshow(Y,'Border','tight');