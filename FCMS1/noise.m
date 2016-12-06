y=im2double(imread('33.bmp'));
randn('seed',0);
sigma=25;
z=y+(sigma/255)*randn(size(y));

figure;imshow(z,'Border','tight');
 imwrite(z,'nn2.jpg');