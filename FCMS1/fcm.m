function [u,v,step_num,time] =fcm(image_data,init_v,cluster_num,m,min_distance,max_step);
%
%init para
[image_row,image_col]=size(image_data);
image_pixel_num=image_row*image_col;
image_vect=reshape(image_data,image_pixel_num,1);
step_num=0;

pre_u=zeros(image_pixel_num,cluster_num);
pre_v=init_v; 

v=zeros(1,cluster_num);                 % v:1*cluster_num
u=zeros(image_pixel_num,cluster_num);   % u:image_pixel_num*cluster_num  
tic;
while(1)
    %computer u
    for i=1:cluster_num      
        u_temp= dist2(image_vect,pre_v(1,i));
        u_temp(find(u_temp<=0.000000001))=0.000000001;
        u(:,i) = u_temp.^(-1/(m-1));                 % u(:,i):image_pixel_num*1   u:q*cluster_num
    end;
    u_sum=sum(u,2);
    u=u./repmat(u_sum,1,cluster_num);  % u:q*cluster_num
     
    %computer v
    v_numerator=u.^m.*repmat(image_vect,1,cluster_num);    
    v_numerator=sum(v_numerator,1);                                            % v_numerator:1*cluster_num
    v_denominator=sum(u.^m,1);   % v_denominator:1*cluster_num
    v_denominator(find(v_denominator<=0.000000001))=0.000000001;
    v=v_numerator./v_denominator;                                              % v:1*cluster_num
    
    if (norm(pre_u-u)<min_distance)&&(norm(pre_v-v)<min_distance)
        fprintf('v=%f',v);
        fprintf('step_num=%d',step_num);
        break;
    else
        %迭代运算后的u和v的赋值
        pre_u=u;
        pre_v=v;         
        step_num=step_num+1;
    end;
     
    %强制结束
    if step_num>max_step
        fprintf('the loop time is exceed!');
        break;       
    end;            
end;
time=toc;
