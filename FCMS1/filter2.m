function filter_value = filter2(temp_image)

% computer the median-filtered image 
[window_size,pixel_num]=size(temp_image);
center_pixel_index=ceil(window_size/2);
temp = temp_image(1:center_pixel_index-1,:);
temp = [temp;temp_image(center_pixel_index+1:window_size,:)]
filter_value=median(temp);