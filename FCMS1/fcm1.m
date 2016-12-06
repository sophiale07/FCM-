%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 标准的FCM算法
tic 
a=imread('tu2.jpg');
[row,column,c]=size(a);
if c~=1
    a=rgb2gray(a);
end
 
a=double(a);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 几个参数
cluster_num=2
threshold=0.000001;
m=1.75;
iter_num=200;
 
%%%%%%%%%%%%%%%%%%%%%%%
% 初始化隶属度
for(i=1:row)
    for(j=1:column)
        memsum=0;
        for(k=1:cluster_num)
            membership(i,j,k)=rand();
            memsum=memsum+membership(i,j,k);
        end
        
        for(k=1:cluster_num)
            membership(i,j,k)=membership(i,j,k)/memsum;
        end
    end
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 初始化聚类中心
 
for(k=1:cluster_num)
    center(k)=0;
    memsum=0;
    for(i=1:row)
        for(j=1:column)
            center(k)=center(k)+membership(i,j,k)^m *a(i,j);
            memsum=memsum+membership(i,j,k)^m;
        end
    end
    center(k)=center(k)/memsum;
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 求初始距离
for (i=1:row)
    for(j=1:column)
        for(k=1:cluster_num)
            dist(i,j,k)=abs(a(i,j)-center(k));
        end
    end
end
 
for(i=1:iter_num)
    costfunction(i)=0.0;
end
 
for(i=1:row)
    for(j=1:column)
        for(k=1:cluster_num)
            costfunction(1)=costfunction(1)+membership(i,j,k)^m* dist(i,j,k)^2;
        end
    end
end
 
fprintf('iter.count = %d, obj. fcn = %f\n',1, costfunction(1));
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 开始迭代
for(it=2:iter_num)
    % 更新隶属度
    costfunction(it)=0.0;
    for(i=1:row)
        for(j=1:column)
            for(k=1:cluster_num)
                membership(i,j,k)=0;
                for(kk=1:cluster_num)
                    membership(i,j,k)=membership(i,j,k)+(dist(i,j,k)/dist(i,j,kk))^(2/(m-1));
                end
                membership(i,j,k)=1/membership(i,j,k);
            end
        end
    end     
     
        
    % 更新聚类中心
    for(k=1:cluster_num)
        center(k)=0;
        memsum=0;
        for(i=1:row)
            for(j=1:column)
                center(k)=center(k)+membership(i,j,k)^m *a(i,j);
                memsum=memsum+membership(i,j,k)^m;
            end
        end
        center(k)=center(k)/memsum;
    end  
    
    % 更新距离
    for (i=1:row)
        for(j=1:column)
            for(k=1:cluster_num)
                dist(i,j,k)=abs(a(i,j)-center(k));
            end
        end
    end
    
    % 目标函数
    for(i=1:row)
        for(j=1:column)
            for(k=1:cluster_num)
                costfunction(it)=costfunction(it)+membership(i,j,k)^m*dist(i,j,k)^2;
            end
        end
    end
 
    fprintf('iter.count = %d, obj. fcn = %f\n',it, costfunction(it));
    
    if abs(costfunction(it)-costfunction(it-1))<threshold
        break;
    end   
end
 toc
for(i=1:row)
    for(j=1:column)         
        maxmembership=membership(i,j,1);
        index=1;
        for(k=2:cluster_num)            
            if(membership(i,j,k)>maxmembership)
                maxmembership=membership(i,j,k);
                index=k;
            end
        end
        newimg(i,j)=round(255*(1-(index-1)/(cluster_num-1)));
    end
end
 
imshow(uint8(newimg));
