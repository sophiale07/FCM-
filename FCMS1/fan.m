function demo()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% image_data=double(imread('tu2.jpg'));
% image_data=1-image_data./255;
% [image_row,image_col] = size(image_data);
%  cluster_show_image=zeros(image_row-1,image_col-1);
%   cluster_show_image=image_data;
%    figure;imshow(cluster_show_image,'Border','tight' ); 
   
   
 image_data=double(imread('33.jpg'));
image_data=1-image_data./255;
image_data=image_data(:,:,1);
[image_row,image_col] = size(image_data);

  figure;imshow(image_data,'Border','tight' );  
end

