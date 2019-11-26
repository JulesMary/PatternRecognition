clear all
close all
clc

function show_joint_probs(min_val, max_val, digit)
  load(strcat("digit", int2str(digit), ".mat"));
  % get the size of D
  [height, width] = size(D);
  % matrix of max and min value
  max_mat = ones(height, width).*max_val;
  min_mat = ones(height, width).*min_val;
  % see where we have values that are greater than the min
  greater_min = D >= min_mat;
  % see where we have values that are smaller than the max
  smaller_max = D <  max_mat;
  % get the sum of those values and divide by the number of different digits
  prob_min = sum(greater_min)./height;
  prob_max = sum(smaller_max)./height;
  % joint probability by multiplying both probabilities
  joint_prob = prob_max.*prob_min;
  
  %prob_range = linspace(min(joint_prob), max(joint_prob), 256);
  
  % get the range to fit the gray values
  prob_range = linspace(0, 1, 256);
  for i = 1:length(joint_prob)
    joint_prob(i) = find(prob_range >= joint_prob(i), 1, 'first') -1;
  endfor
  % get size 28 x 28
  joint_prob = reshape(joint_prob,	[28,28])';
  % display the result
  figure,	imshow(joint_prob,[]);
  title(cstrcat('joint probability for digit ', num2str(digit) , ' with min: ', num2str(min_val), ' and max: ', num2str(max_val) ))
endfunction

min_vals = [0, 1, 50, 250];
max_vals = [0, 50, 150, 255];
digit = 7;

for i = 1:length(min_vals)
  show_joint_probs(min_vals(i), max_vals(i), digit)
endfor
