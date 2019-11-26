close all
clc

%980 images stored in a row each with 784 gray values (28x28 pixel)
%a

function [] = show_data(im_num)
  for i = 0:9
    load (["digit", int2str(i), ".mat"])
    for j = 1:im_num
      I = D(j,:);
      I = reshape(I, [28,28]);
      I = imrotate(I, 270);
      I = fliplr(I);
      figure(1), imshow(I,[]);
      pause(0.1);
    endfor
  endfor
endfunction

show_data(5)


