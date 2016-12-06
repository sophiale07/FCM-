function [u,v,step_num] = fast_fcm(image_data,init_v,cluster_num,m,min_distance,max_step,q);
% the algorithm fast fuzzy c-means


% initialize the parameter
[image_row,image_col]=size(image_data);
image_pixel_num=image_row*image_col;
image_vector=reshape(image_data,image_pixel_num,1);
step_num=0;

% pre_u: the previous cluster memberships of the gray values; u_graylevel: the cluster memberships of the gray values
% pre_v: the previous cluster centers of the pixels; v: the cluster centers of the pixels
pre_u=zeros(q,cluster_num);
u_graylevel=zeros(q,cluster_num);
pre_v=init_v;
v=zeros(1,cluster_num);                 

% u: the cluster memberships of the image pixels
u=zeros(image_pixel_num,cluster_num);  

% graylevel_for_image: the gray levels for the image pixels
graylevel_for_image=zeros(image_pixel_num,1);

% compute the gray levels for the image pixels
for i=1:q
    image_vector(find(image_vector==0))=0.000000001;                
    graylevel_for_image(find(image_vector<=(i/q)&image_vector>(i-1)/q),:)=(i-1)/q;     
    graylevel_for_image_num(i,1)=sum(image_vector<=(i/q)&image_vector>(i-1)/q);
    graylevel_for_image_value(i,1)=(i-1)/q;
end;

while(1)
    % compute the cluster memberships for the gray levels
    for i=1:cluster_num
        u_temp=abs(graylevel_for_image_value-repmat(pre_v(1,i),q,1));
        u_temp(find(u_temp<=0.000000001))=0.000000001;
        u_graylevel(:,i) = u_temp.^(-2/(m-1));                 % u(:,i):q*1  u:q*cluster_num
    end;
    u_graylevel_sum=sum(u_graylevel,2);
    u_graylevel=u_graylevel./repmat(u_graylevel_sum,1,cluster_num);  % u:q*cluster_num
     
    %computer the cluster centers v
    v_numerator=u_graylevel.^m.*(repmat(graylevel_for_image_num,1,cluster_num).*repmat(graylevel_for_image_value,1,cluster_num));    
    v_numerator=sum(v_numerator,1);                                            % v_numerator:1*cluster_num
    v_denominator=sum(u_graylevel.^m.*repmat(graylevel_for_image_num,1,cluster_num),1);   % v_denominator:1*cluster_num
    v_denominator(find(v_denominator<=0.000000001))=0.000000001;
    v=v_numerator./v_denominator;                                              % v:1*cluster_num
    
     % if the cluster membership u and the cluster centers v are not changed, the algorithm stops
    if (norm(pre_u-u_graylevel)<min_distance)&&(norm(pre_v-v)<min_distance)
        fprintf('v=%f',v);
        fprintf('step_num=%d',step_num);
        break;
    else      
        pre_u=u_graylevel;
        pre_v=v;         
        step_num=step_num+1;
    end;
     
    % if the iterative step equals max_step, the algorithm also stops 
    if step_num>max_step
        fprintf('the loop time is exceed!');
        break;       
    end;            
end;

% compute the cluster memberships for the image pixels u 
for i=1:q
    u(find(graylevel_for_image==(i-1)/q),:)=repmat(u_graylevel(i,:),graylevel_for_image_num(i,1),1);   
end;