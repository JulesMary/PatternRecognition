clear all
close all
clc

%a
load('iris_data.mat')
load('iris_species.mat')

classes = {"setosa", "versicolor", "virginica"};

% get the indices of the different Classes
all_one = meas(strcmp(classes(1), species),:);

all_two = meas(strcmp(classes(2), species),:);

all_three = meas(strcmp(classes(3), species),:);

iris = cat(3, all_one, all_two, all_three);

%b

%initialize new cell array
iris1	=	cell(51,	5,	3);
% define the headers
header = {"Sepal Length", "Sepal Width", "Petal Length", "Petal Width"};
% set the headers
iris1(1,2:5,1) = header;
iris1(1,2:5,2) = header;
iris1(1,2:5,3) = header;
% set the classes
iris1(1,1,1) = classes(1);
iris1(1,1,2) = classes(2);
iris1(1,1,3) = classes(3);
% array with obs1 to obs50
obs = cell(50,1);
for i = 1:50
  obs(i) = strcat("Obs", num2str(i));
endfor

%set the obs
iris1(2:51,1,1) = obs;
iris1(2:51,1,2) = obs;
iris1(2:51,1,3) = obs;

% set the data
iris1(2:51,2:5,:) = num2cell(iris); 

%c
%cell = iris1;
function printcell(cell)
  [height, width, depth] = size(cell);
  for d = 1:depth;
    line = cell(1,:,d);
    fprintf(1, '%s ', line{:});
    fprintf(1, '\n');
    for h = 2:height;
      line = cell(h,1,d);
      fprintf(1, '%s ', line{:});
      line = cell(h,2:width,d);
      fprintf(1, '   %d    ', line{:});
      fprintf(1, '\n');
    endfor 
  endfor
endfunction

%d
setosa     = reshape([iris1{2:51,	2:5,	1}], 50, 4);
versicolor = reshape([iris1{2:51,	2:5,	2}], 50, 4);
virginica  = reshape([iris1{2:51,	2:5,	3}], 50, 4);

%e
my_array = cell(3,5);
my_array(1,2:5) = header;
my_array(1,1) = "versicolor"
my_array(2,1) = "mean      ";
my_array(3,1) = "variance  ";
my_array(2,2:5) = num2cell(mean(versicolor));
my_array(3,2:5) = num2cell(var(versicolor));
printcell(my_array)

%f
figure
plot(setosa(:,1),setosa(:,2),"o");
hold on
plot(versicolor(:,1),versicolor(:,2),"x");
hold on
plot(virginica(:,1),virginica(:,2),'c*');
xlabel('sepal length')
ylabel('sepal width')
title('sepal length vs. sepal width')
legend('setosa', 'versicolor', 'virginica')
grid on

figure
plot(setosa(:,1),setosa(:,3),"o");
hold on
plot(versicolor(:,1),versicolor(:,3),"x");
hold on
plot(virginica(:,1),virginica(:,3),'c*');
xlabel('sepal length')
ylabel('petal length')
title('sepal length vs. petal length')
legend('setosa', 'versicolor', 'virginica')
grid on