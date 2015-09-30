% Name: piecewise_rec.m
% Author: Vidhu Nath, Pablo Gutierrez, Alexandros Kontogiorgos-Heintz, Peter LaFontaine

% clear up memory
clear;

% change to appropriate path
path(path,'C:\code\MATLAB\CS_591_C1\l1_magic\Optimization');

disp('Importing data..');
im = importdata('original.mat');
time = im.time;
data = im.data;

clear im;

n_iter = length(data) / 1000;
div = length(data) / n_iter;
rec = [];

% set percentage sampled and number of iterations
samp = 0.175;
%iter = 50;

% loop through component arrays, recover data from original, and
% reconstruct new array through concatenation
for ind = 0:(n_iter - 1)
    fprintf('Beginning teration: %d\n',ind+1);
    ind0 = ind*div + 1;
    indf = (ind+1)*div;
    xprec = rec_pd(data(ind0:indf),samp);
    rec = cat(1,rec,xprec);
    clear xprec
end

% calculate error
temp = zeros(length(rec), 1); 
for n = 1:length(rec)
    temp(n) = abs((rec(n) - data(n))) / data(n); 
end

disp('Saving files...');
recover.time = time;
recover.data = rec;
save recovered.mat recover;

disp('Plotting...');
f = figure;

subplot(3,1,1)
plot(time,data);
title('Original Data vs Time (n = 100000)');
xlabel('Time (ms)');
ylabel('Action Potential (mV)');

subplot(3,1,2)
plot(time,rec)
title('Recovered Data (sampling = 0.20)');
xlabel('Time (ms)');
ylabel('Action Potential (mV)');

subplot(3,1,3)
plot(time,temp);
title('Error over time');
xlabel('Time (ms)');
ylabel('Error Percentage (%)');

clear ind0 indf samp iter n_iter ind div temp n f data test_time;
fprintf('Finished "piecewise_rec" execution.\n');

%eof

