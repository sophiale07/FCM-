function filter_value = s_filter(temp_image,gray_scale, spatial_scale)

% compute Sij for a given image
S=compute_S(temp_image,gray_scale,spatial_scale);                   

% computer the generated image computed by Sij
neighbor_pixel_value_sum=sum(S.*temp_image,1); 
S_sum=sum(S,1);  
filter_value=neighbor_pixel_value_sum./S_sum;