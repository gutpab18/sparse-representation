%{

Name: l1_rec.m

Author: Vidhu Nath, Pablo Gutierrez, Alexandros Kontogiorgos-Heintz, Peter LaFontaine

Description: 

This script is used to run through POGO-SPKCO1 data to produce
a recovered data set. This script is all that is necessary to run the
algorithms, all that needs to be set is the location of the POGO data.
This script operates by first opening the POGO data and extracting the
data size desired (extract_sample_data.m). 

Then this value is used to run through the algorithm that reconstructs the data, 
thereby producing the recovered data and the error associated with it (piecewise_rec.m) 
by calling a function which runs the l1-minimization (rec_pd.m). 

The final component produces a "threshold" graph of the data, so that anything 
over or under the mean by a set standard deviation is set to 0, and all other
data remains the same (threshold.m). This is used to determine the shape
and peaks of the neuron spikes without needing to muddle through all of the
noise in the data.

Note: All data is saved as objects in the current working directory in the
form of "obj.data" and "obj.time" for easy access after running the
scripts.

Note: Please change the locations of the POGO files and the POGO file data
name in first section or else the code will not run.

%}

% 
% Name: extract_sample_data.m
% Description: Script to extract n values from the original data to use
% further.

% NOTE: Please change the locations of where the file is saved and what the
% name of the POGO data is.

% clear up memory
clear;

% PLEASE CHANGE TO THE CURRENT WORKING DIRECTORY
cd('C:\code\MATLAB\CS_591_C1\');

disp('Importing original data...');
pogo1 = importdata('Pogo_SPKC01.mat');  % PLEASE CHANGE TO APPROPRIATE VALUE

disp('Extracting sample data...');
n = 2400;                   % size of extracted data
datas = pogo1.data(1:n);
times = pogo1.time(1:n);

clear pogo1 n ans;

% values for data and time are saved in the "original" object
disp('Saving extracted data...');
original.time = times;
original.data = datas;
save original.mat original;

fprintf('Finished "extract_sample_data" execution.\n\n');

% 
% Name: piecewise_rec.m
% Description: Calls the function "rec_pd.m" to execute the algorithm that
% reconstructs the original data through the l1 minimization algorithm
% called the "primal-dual interior point" method.
%
% This script can manage large data sets (n = 1,000,000+) relatively easily
% by breaking up the data processing into chunks of more manageable size.
% This removes the memory limit MATLAB has.

% clear up memory
clear;

disp('Importing data..');
im = importdata('original.mat');
time = im.time;
data = im.data;
clear im;

% set the number of loops that for loop will run through
n_iter = ceil(length(data) / 1000);
div = length(data) / n_iter;
rec = [];

% set percentage sampled and number of iterations
samp = 0.10;
iter = 50;

sprintf('\n');

% loop through component arrays, recover data from original, and
% reconstruct new array through concatenation
for ind = 0:(n_iter - 1)
    fprintf('Beginning teration: %d\n',ind+1);
    ind0 = ind*div + 1;
    indf = (ind+1)*div;
    xprec = rec_pd(data(ind0:indf),samp,iter);
    rec = cat(1,rec,xprec);
    clear xprec
end

sprintf('\n');

% calculate error array
temp = zeros(length(rec), 1); 
for n = 1:length(rec)
    temp(n) = abs((rec(n) - data(n))) / data(n); 
end

% save recovered data and time in "recovered" object
disp('Saving files...');
recovered.time = time;
recovered.data = rec;
save recovered.mat recovered;

% produce plots of different graphs to compare original and recovered data
% as well as the percentage difference between the two

disp('Plotting...');
f = figure;

subplot(3,1,1)
plot(time,data);
title('Original Data vs Time (n = 2400)');
xlabel('Time (ms)');
ylabel('Action Potential (mV)');

subplot(3,1,2)
plot(time,rec)
title('Recovered Data (sampling = 0.10)');
xlabel('Time (ms)');
ylabel('Action Potential (mV)');

subplot(3,1,3)
plot(time,temp);
title('Error over time');
xlabel('Time (ms)');
ylabel('Error Percentage (%)');

saveas(f,'test','fig');

clear ind0 indf samp iter n_iter ind div n f data test_time;
fprintf('Finished "piecewise_rec" execution.\n\n');


% 
% Name: threshold.m
% Description: Sets every value that is greater than max_stddev and less
% than min_stddev from the mean of the entire data set to 0. This clears up
% the noise and retains the actual signal noise.

% clear up memory
clear;

im = importdata('recovered.mat');
time = im.time;
data = im.data;
clear im;

avg = mean(data);
stddev = std(data);

% set the number of standard deviations to bound the data
% number of standard deviations set through empirical testing
sig = 2.7;
min_stddev = avg - sig*stddev;
max_stddev = avg + sig*stddev;

% remove values bounded by the min and max stddev
for ind = 1:length(data)
    if data(ind) < max_stddev && data(ind) > min_stddev
        data(ind) = 0;
    end
end

% save thresholded data and time in "thresh" object
thresh.time = time;
thresh.data = data;
save thresholded.mat thresh;

%ft = fft(data);
f1 = figure;
plot(time,data);
title('Thresholded Data Values (n = 100,000)');
xlabel('Time (ms)');
ylabel('Action Potential (mV)');

clear ind n avg stddev f1 min_stddev max_stddev;

fprintf('Finished "thresh_data" execution.\n');

%eof

