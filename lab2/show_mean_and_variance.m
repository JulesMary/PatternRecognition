clear all
close all
clc

for i = 0:9
  load(strcat("digit", int2str(i), ".mat"));
  % each column is the same pixel, so we calcucalte the mean columnwise
  Mean = mean(D,1);
  % get size 28 x 28
  Mean = reshape(Mean,	[28,28])';
  % display the mean values
  figure,	imshow(Mean,[]);
  
  % also calculate the variance columnwise
  Var = var(D,0,1);
  % get size 28 x 28
  Var = reshape(Var,	[28,28])';
  % display
  figure,	imshow(Var,[]);  
endfor
