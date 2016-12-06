clear all%清除workspace中的所有变量
clc;%清楚命令窗口的内容
I=imread('syn3G30.bmp');%读入图像文件


I1=double(I); 
c=2
[m,n]=size(I1);
D1=cell(m,n);
for i=1:m
    for j=1:n
        D1{i,j}=zeros(c,1);
    end
end
flag=0;
Isum=zeros();        
Isum=sum(I1);
I_sum=sum(Isum);
I_mean=I_sum/(m*n);
for i=1:m
    for j=1:n
        flag=flag+(I1(i,j)-I_mean)^2;
    end
end
h=0;
for i=1:m
    for j=1:n
        h=h+((I1(i,j)-I_mean)^2-flag/(m*n))^2;
    end
end
h=1/sqrt(h/(m*n-1));
[U1,V1]=Initialization(I1,c);
for i=1:m
    for j=1:n
        for k=1:c
            D1{i,j}(k,1)=exp((-1)*h*(I1(i,j)-V1(k))^2);
        end
    end
end
            

