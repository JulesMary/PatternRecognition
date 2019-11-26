clear all
close all
clc

%a
function show_data(im_num)
  % consider all digits from 0 to 9
  for i = 0:9;
    load(strcat("digit", int2str(i), ".mat"));
    % im_num is how many pictures of each digit will be displayed
    for	j	=	1:im_num
             % every row of D is one picture
             I	=	D(j,:);
             % reshape the row into a 28 x 28 matrix
             I	=	reshape(I,	[28,28]);
             % rotate the picture
             I = I';
             % display the picture
             figure,	imshow(I,[]);
             pause(0.1);
    end
  end
endfunction

show_data(2)



