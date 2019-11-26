close all;
clc;
clear all;


for i = 0:9
  load (["digit", int2str(i), ".mat"])
  % compute the mean of each column (rows are images, columns are pixel)
  M = mean(D);
  %reshape and rotate
  M = reshape(M, 28, 28);
  M = flipud(M);
  M = imrotate(M, 270);

  % same for varianz
  S = var(D);
  S = reshape(S, 28, 28);
  S = flipud(S);
  S = imrotate(S, 270);
  
  % plot 2 images
  figure(1);
  subplot(121);
  imshow(M, []);
  title('Mean of all images')

  subplot(122);
  imshow(S, []);
  title('Variance of all images')
  pause(0.1);

endfor