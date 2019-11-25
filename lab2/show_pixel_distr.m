  load(['digit3.mat']);
  
  A = D(:,297); % get whole column 297. Means: all 297rd Pixels of each image in D
  a = [];
  vals = [];
  
  % go trough possible values and count how often the pixel has that value
  for i = 1:256
    v = i-1;
    freq = length( find( A == v ) );
    a = [a freq];
    vals = [vals v];
  end
  
  % plot distribution
  bar( vals, a );
  set(gca,'xtick', 0:32:256);