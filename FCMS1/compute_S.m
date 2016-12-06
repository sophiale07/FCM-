function S=compute_S(temp_image, gray_scale,spatial_scale)

% initialize the parameters
[window_size,image_pixel_num]=size(temp_image);
center_pixel_index=ceil(window_size/2);
center_pixel_value=temp_image(center_pixel_index,:);                         
pixel_distance=(temp_image-repmat(center_pixel_value,window_size,1)).^2; 

% determine the valid region according to the window size
S_valid = ones(window_size,image_pixel_num);
S_valid(center_pixel_index,:)=0;

% compute the Sij_g
average_pixel_distance=sum(pixel_distance.*S_valid,1)./sum(S_valid,1);
sigma=gray_scale.*average_pixel_distance;                                 
sigma(find(sigma<=0.000000001))=0.000000001;
S_gray=exp(-1*(temp_image-repmat(center_pixel_value,window_size,1)).^2./repmat(sigma,window_size,1));

% compute the Sij_s
if window_size==3*3   
    S_spatial= repmat(exp(-1*[1;1;1;1;0;1;1;1;1]/spatial_scale),1,image_pixel_num);
end;
if window_size==5*5
    S_spatial= repmat(exp(-1*[4;3;2;3;4; 3;2;1;2;3; 2;1;0;1;2; 3;2;1;2;3; 4;3;2;3;4;]/spatial_scale),1,image_pixel_num);   
end;

% computer the Sij for a given image
S=S_valid.* S_gray.* S_spatial;