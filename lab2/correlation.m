close all
clear all
clc

digit = 5;
x_coor = 23;
y_coor = 9;
function show_correlation	(digit,	x_coor,	y_coor)
  load(strcat("digit", int2str(digit), ".mat"));
  [height, width] = size(D);
  % calculate the pixels number from the coordinates
  pixel = (y_coor - 1) * 28 + x_coor;
  % consider only the pixels column
  pix_vec = D(:,pixel);
  corr_mat = [];
  % calculate the correlation with the other pixels
  for i = 1:width
    corr_mat = [corr_mat corr(pix_vec, D(:,i))];
  endfor
  
  % get size 28 x 28
  corr_mat = reshape(corr_mat,	[28,28])';
  % show where the considered pixel is
  black = zeros(1,width);
  black(pixel) = 255;
  show_pixel = reshape(black, [28,28])';
  % display the result
  figure
  subplot(1,2,1)
  imshow(show_pixel,[])
  title('considered pixel')
  subplot(1,2,2)
  title('correlation')
  imshow(corr_mat,[])
endfunction

show_correlation(digit,	x_coor,	y_coor);