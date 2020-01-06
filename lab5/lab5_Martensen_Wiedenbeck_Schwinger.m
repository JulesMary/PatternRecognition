clear all
close all
clc

load('twoClasses.mat')

%a

% initialize new cell array
cloud1 = cell(2001,3,2);
% generate the observation names and insert them
obsnames = strcat({'Obs'},num2str((1:2000)','%d'));
cloud1(2:end,1,:) = repmat(obsnames,[1 2]);
cloud1(1,1,1) = 'Class0';
cloud1(1,1,2) = 'Class1';
% generate the sensor names and insert them
sensors = strcat({'Sensor'},num2str((1:2)','%d'));
cloud1(1,2:end,:) = repmat(sensors,[1 2]);
% insert the data
cloud1(2:end,2:end,1) = num2cell(patterns(:,1:2000)');
cloud1(2:end,2:end,2) = num2cell(patterns(:,2001:end)');
% generate four variables to work with
class0_sensor1 = patterns(1,1:2000);
class0_sensor2 = patterns(2,1:2000);
class1_sensor1 = patterns(1,2001:end);
class1_sensor2 = patterns(2,2001:end);

%b
% compute the covariance to decide if dependent or independent
test1 = cov(class0_sensor1,class0_sensor2);
test2 = cov(class1_sensor1,class1_sensor2);
% compute the mean of each variable
m01 = mean(class0_sensor1);
m02 = mean(class0_sensor2);
m11 = mean(class1_sensor1);
m12 = mean(class1_sensor2);
% compute the standard deviation of each variable
s01 = sqrt(var(class0_sensor1));
s02 = sqrt(var(class0_sensor2));
s11 = sqrt(var(class1_sensor1));
s12 = sqrt(var(class1_sensor2));

% generate a grid to work on for both classes
pts_x = linspace(min(min(class0_sensor1),min(class1_sensor1)), ...
        max(max(class0_sensor1),max(class1_sensor1)),100);
pts_y = linspace(min(min(class0_sensor2),min(class1_sensor2)), ...
        max(max(class0_sensor2),max(class1_sensor2)),100);

% compute marginal distributions        
px01 = exp(-0.5*((pts_x-m01)./s01).^2)./(sqrt(2*pi)*s01);
px02 = exp(-0.5*((pts_y-m02)./s02).^2)./(sqrt(2*pi)*s02);
px11 = exp(-0.5*((pts_x-m11)./s11).^2)./(sqrt(2*pi)*s11);
px12 = exp(-0.5*((pts_y-m12)./s12).^2)./(sqrt(2*pi)*s12);

% compute the joint probabilities for each class
jp0 = px02'*px01;
jp1 = px12'*px11;

% posterior probabilities
% prior probabilities are the same so they cancel out
p_0_x = jp0 ./ (jp0 .+ jp1);
p_1_x = jp1 ./ (jp0 .+ jp1);

% plot distributions, gaussian distributions and decision boundary
figure
contourf(pts_x, pts_y, p_1_x, [0.5 0.5], 'k-.');
colormap(copper)
hold on
p1 = plot(class0_sensor1, class0_sensor2,'*b');
p2 = plot(class1_sensor1, class1_sensor2,'*c');
contour(pts_x,pts_y,jp1)
contour(pts_x,pts_y,jp0)
grid on
legend([p1,p2],{'Class 0','Class 1'},'Location','southwest')
xlabel('Sensor 1')
ylabel('Sensor 2')



C1 = 0.4*double(p_1_x > p_0_x);
C2 = 0.6*double(p_0_x > p_1_x);
C = C1+C2;
figure
hold on;
surf(pts_x, pts_y, jp0, C);
surf(pts_x, pts_y, jp1, C);
view(40, 40);
colormap winter
grid;
xlabel('Sensor 1')
ylabel('Sensor 2')
zlabel('likelihood')
title('Class Conditionals')

figure
hold on
surf(pts_x, pts_y, p_0_x, 'FaceColor','g');
surf(pts_x, pts_y, p_1_x, 'FaceColor','b');
view(40, 40);
colormap winter
grid;
xlabel('Sensor 1')
ylabel('Sensor 2')
zlabel('Posterior Probability')
title('Posterior Probability')