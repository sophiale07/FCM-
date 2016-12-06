function filter_value=filter1(temp_image)

% computer the mean-filtered image 
[window_size,pixel_num]=size(temp_image);
center_pixel_index=ceil(window_size/2);
filter_value=(sum(temp_image,1)-temp_image(center_pixel_index,:))./(window_size-1);  