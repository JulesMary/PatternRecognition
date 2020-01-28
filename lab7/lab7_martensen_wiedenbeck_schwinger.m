clear all
close all
clc


 %  generate 50 different sets of 100 normally distributed training samples with different means and standard deviations
 
data=[];
for i = 0:49
    D=randn(100);
    Dcolum = D(1,:)';
    data = [data,Dcolum];
end
for j=1:size(data,2)
    for i=1:size(data,1)
      newMean = abs(rand(1));
      stddiv = abs(rand(1));
      data(i,j) = (data(i,j) * stddiv) + newMean;
        if data(i,j)<0
            data(i,j)=0;
            end
    end
end
 
 % For each data set, determine the Maximum-likelihood estimate for parameter λ
 for j= 45:size(data,2)
   lle = 1 / mean(data)(j); % compute Maximum-likelihood estimate for parameter λ 
   T = randn(100,1) + lle; % generate 100 training λ parameters arround lle
   sumCol =  sum(data(j,:));
   T  =  [T,  log(T) * size(data,2) - T * sumCol];
   T = sort(T,1); % sort for plotting
   plot(T(:,1),T(:,2)); %plot
   
 endfor


