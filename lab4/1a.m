clear;
close all;
clc;

%10.000 2-d datapoints stored in 2 columns: colunm 1 = dim1, column 2 = dim2
load "./a.mat";
figure(1)
%visualize data points
subplot(2, 2, 1);
plot(a(:,1),a(:,2),".");

% store first and second dimension each
xx = a(:,1);
yy = a(:,2);
%calculate range of values
t1 = min(xx(:)) - 1:0.1:max(xx(:)) + 1; 
t2 = min(yy(:)) - 1:0.1:max(yy(:)) + 1; 
%mean over the first dimension
meanD1 = mean(a(:,1)); 
%standard deviation of first dimension
sD1 = sqrt(var(a(:,1)));
%same for second dimension
meanD2 = mean(a(:,2));  	
sD2 = sqrt(var(a(:,2)));
%calculate gaussian density for both dimensions
x = exp(-0.5*((t1-meanD1)/sD1).^2)./(sqrt(2*pi)*sD1);
y = exp(-0.5*((t2-meanD2)/sD2).^2)./(sqrt(2*pi)*sD2);
y_transposed = y'
%plot the contour
hold on;
contour(t1, t2, y_transposed*x);
title("Gaussian with independent components 2D");
xlabel("x");
ylabel("y");
%add subplot 3D
subplot(2, 2, 2);
mesh(t1, t2, y_transposed*x);
title("Gaussian with independent components 3D");
xlabel("x");
ylabel("y");
