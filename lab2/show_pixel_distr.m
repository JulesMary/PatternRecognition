clear all
close all
clc

%c
% specify the number of the considered pixel
pixel_num = 297;
% specify the number of the considered digit
digit = 3
load(strcat("digit", int2str(digit), ".mat"));

% just look at the considered pixel
D = D(:,pixel_num);

% comupte the frequency of all gray values
freq = [];
for i = 0:255;
  x = length(find(D == i)); 
  freq = [freq x];
endfor

% display frequency in a histogram
figure
bar(freq)
grid on
title('gray value distribution of pixel 297 for digit 3')
