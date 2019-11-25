% d

load(['digit3.mat']);

pixel_positions = [10 100 175 220 285 370 445 540 620 680]
%pixel_positions = [300]

for i = pixel_positions

  P = zeros(1, 28*28);
  P(i) = 255;
  P = reshape(P, [28,28]);
  c = find(pixel_positions == i);
  figure(c), imshow(P,[]);

  % pause(1);

  A = D(:,i); % get whole column i. Means: all i-th Pixels of each image in D
  a = [];
  vals = [];

  % go trough possible values and count how often the pixel has that value
  for j = 1:256
    v = j-1;
    freq = length( find( A == v ) );
    a = [a freq];
    vals = [vals v];
  end

  % plot distribution
  figure(c+1), bar( vals, a );
  set(gca,'xtick', 0:32:256);
  
  pause(3);
  
end