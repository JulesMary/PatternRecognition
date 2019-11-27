clear all
close all
clc

%d

% specify the considered digit
digit = 7;
load(strcat("digit", int2str(digit), ".mat"));
[height, width] = size(D);

% calculate the varince to see interesting spots
Var = var(D,0,1);
% get the 10 highest values of variance
sorted = flip(sort(Var))(1:10);

% get the index of our pixels of interest
pix = []
num = 1:784;
for i = 1:10
  pix = [pix num(Var == sorted(i))];
endfor

for pixel_num = pix
  D_col = D(:,pixel_num);
  % compute the frequency of all gray values
  freq = [];
  for i = 0:255;
    x = length(find(D_col == i)); 
    freq = [freq x];
  endfor
  
  % illustrate which pixel we're considering
  black = zeros(1,width);
  black(pixel_num) = 255;
  show_pixel = reshape(black, [28,28])';
  %plot the histogram
  figure
  bar(freq)
  grid on
  title(cstrcat('gray value distribution of pixel ',num2str(pixel_num),' for digit ', num2str(digit)))
  figure
  imshow(show_pixel,[]); 
  title(cstrcat('pixel number ',num2str(pixel_num)))
endfor
