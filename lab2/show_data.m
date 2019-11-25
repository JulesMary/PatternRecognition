
% (a)

function I = ex_2a(im_num)

files = dir('*.mat'); 
    for i = 1:numel(files) 
        load(['digit' int2str(i-1) '.mat'])
        
        for j = 1:im_num
            I = D(j,:);
            I = reshape(I, [28,28]); % converts I to size to 28 x 28
            % I = imrotate(I, 90);
            figure(1), imshow(I,[]);
            pause(0.1);
        end 
    end
end

ex_2a(3);