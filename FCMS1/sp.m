%P2=imnoise(M,'salt & pepper',0.02)
X=imread('t.bmp');
Y=imnoise(X,'salt & pepper',0.15);%%
figure; imshow(Y,'Border','tight');