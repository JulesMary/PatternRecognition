clear all
close all
clc

load 'train_images.mat'
load 'train_labels.mat'

faceFeats = [];
nonFaceFeats = [];
numPix = 0;
images = train_images;
labels = train_patterns;
for i = 1:size(images,1)

 I = images(i,:); % get next image from image matrix
 I = reshape(I, [112,92]); % form a matrix from row vector
 P = labels(i,:); % get next label matrix
 P = reshape(P, [112,92]);

 % Convert all possible neighborhoods in image to columns
 % B contains as many columns as the number of pixels in I. (This
 % is achieved by adding zeros at the image margin.) im2col is contained
 % in the Octave package image. If it is not available on your
 % system you may write its functionality on your own.
 B = im2col(padarray(I, [1, 1], 0, 'both'), [3, 3], 'sliding');
 faceFeatsNew = B(:,logical(P(:)));
 nonFaceFeatsNew = B(:,~logical(P(:)));
 faceFeats = [faceFeats faceFeatsNew];
 nonFaceFeats = [nonFaceFeats nonFaceFeatsNew];
end

MF = mean(faceFeats,2);
MFmat = repmat(MF,1,10304);
CF = cov(double(faceFeats'));

MN = mean(nonFaceFeats,2);
MNmat = repmat(MN,1,10304);
CN = cov(double(nonFaceFeats'));

load 'test_images.mat'
images = test_images;

%bayes
p1 = size(faceFeats,2)/(size(faceFeats,2)+size(nonFaceFeats,2));
p2 = size(nonFaceFeats,2)/(size(faceFeats,2)+size(nonFaceFeats,2));

for i = 50:54%size(images,1)

 I = images(i,:); % get next image from image matrix
 I = reshape(I, [112,92]); % form a matrix from row vector
 B = im2col(padarray(I, [1, 1], 0, 'both'), [3, 3], 'sliding');
 % distance
 dist1 = sum((double(B) - MFmat).^2);
 dist2 = sum((double(B) - MNmat).^2);
 res_dist = dist1 < dist2;
 % Reshape result into a 2D image
 class_dist = reshape(res_dist, [112,92]);
 % bayes
 
 % Compute the likelihoods (class-conditional probabilities) for both
 % classes
 p_x_1 = mvnpdf(double(B'), MF', CF');
 p_x_2 = mvnpdf(double(B'), MN', CN');

 p_x_1_p_1 = p_x_1 * p1;
 p_x_2_p_2 = p_x_2 * p2;
      
 % Compare according to Bayes decision rule
 % Decision for class with largest probability -> face pixels will be set to 1
 res_bay = p_x_1_p_1 > p_x_2_p_2;
 
 % Reshape result into a 2D image
 class_bay = reshape(res_bay, [112,92]); 
 

 figure
 subplot(1,2,1)
 imshow(class_dist);
 title('minimum distance classifier')
 subplot(1,2,2)
 imshow(class_bay)
 title('bayes classifier')
 
end



