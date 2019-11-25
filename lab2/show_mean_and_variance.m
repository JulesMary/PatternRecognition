% (b)

files = dir('*.mat'); 
for i = 1:numel(files) 
  load(['digit' int2str(i-1) '.mat']);
  I = mean(D);
  I = reshape(I, [28,28]);
  figure(1), imshow(I,[]);
  pause(1);
  I = var(D);
  I = reshape(I, [28,28]);
  figure(1), imshow(I,[]);
  pause(1);
end

