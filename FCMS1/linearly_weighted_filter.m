function linearly_weighted_value=linearly_weighted_filter(temp_image,alpha)

% computer the linearly_weighted iamge
[window_size,pixel_num]=size(temp_image);
center_pixel_index=ceil(window_size/2);
linearly_weighted_value=temp_image(center_pixel_index,:)+alpha/(window_size-1)*(sum(temp_image)-temp_image(center_pixel_index,:));
linearly_weighted_value=linearly_weighted_value/(1+alpha);
