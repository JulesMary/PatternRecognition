clear all
close all
clc


 %  generate 50 different sets of 100 normally distributed training samples with different means and standard deviations
 
data=[];
for i = 0:49
    mean_v = abs(rand(1));
    stddiv = abs(rand(1));
    dat = stddiv.*randn(100,1) + mean_v;
    data = [data, dat];
end

 
 % For each data set, determine the Maximum-likelihood estimate for parameter ?
 for j = 1:5%size(data,2)
   pos_vals = data(:,j);
   pos_vals = pos_vals(pos_vals > 0);
   lle = 1 / mean(pos_vals); % compute Maximum-likelihood estimate for parameter ? 
   lambdas = randn(100,1) + lle; % generate 100 training ? parameters arround lle
   lambdas = sort(lambdas);
   lambdas = lambdas(lambdas > 0);
   sum_vals =  sum(pos_vals);
   T  =  [lambdas,  log(lambdas).*size(pos_vals) - lambdas.*sum_vals];
   %T = sort(T,1); % sort for plotting
   figure
   plot(T(:,1),T(:,2)); %plot
   hold on
   plot([lle,lle],[min(T(:,2))+10,max(T(:,2))+10]);   
 end

