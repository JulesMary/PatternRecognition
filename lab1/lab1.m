clear all;
close all;
clc;
hold off;

N = 100;


%fix rounds towards zero, so the values for A are in the interval [0, 10)
%rand creates uniformly distributed random numbers
A = fix(10*rand(N));
% round rounds to the nearest integer so the values for B are in the interval [0, 10]
% randn creates normally distributed numbers with zero mean and variance one.
B = round(10*randn(N));

minA = min(A(:));
maxA = max(A(:));

minB = min(B(:));
maxB = max(B(:));

%for each element i in the matrix: store the length of the vector, find(A==i) returns
a = [];
for i = minA:maxA
  a = [a length(find (A==i))];
end
%same for B
b = [];
for i=minB:maxB
  b = [b length(find (B==i))];
end

%figure showing the frequency distribution for a
figure(1);
bar(minA:maxA, a);
axis([minA-1 maxA+1]);
title("Frequency Distribution A")
xlabel("Value")
ylabel("Frequency")

%line indicating the mean
hold on;
line([minA-1 maxA+1],[mean(a(:)) mean(a(:))], 'Color','r');
hold off;

%figure showing the frequency distribution for b
figure(2);
bar(minB:maxB, b);
axis([minB-1 maxB+1]);
title("Frequency Distribution B")
xlabel("Value")
ylabel("Frequency")

%compute the relative frequencies
relFr_a = a./N^2;
relFr_b = b./N^2;

figure(3);
bar(minA:maxA, relFr_a);
axis([minA-1 maxA+1]);
title("Relative Frequencies A")
xlabel("Value")
ylabel("Rel Frequency")

figure(4);
bar(minB:maxB, relFr_b);
axis([minB-1 maxB+1]);
title("Relative Frequencies B")
xlabel("Value")
ylabel("Rel Frequency")

% compute the probability masses -> should sum up to 1
sumA = sum(relFr_a)
sumB = sum(relFr_b)

% normal dist 
x = minB:0.1:maxB;
m = mean(B(:));
s = std(B(:));
% 
f = exp(-0.5*((x-m)./s).^2)./(sqrt(2*pi)*s);
hold on;
plot(x, f, 'g');

%check intervals
inInterval = length(find(B > (s*-1) & B<s));
lengthB = length(B(:));
bInS = inInterval/lengthB

inInterval2 = length(find(B > (s*-2) & B<2*s));
bInS2 = inInterval2/lengthB

inInterval3 = length(find(B > (s*-3) & B<3*s));
bInS3 = inInterval3/lengthB







