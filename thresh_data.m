% Name: thresh_data.m

% clear up memory
clear;

im = importdata('recovered.mat');
time = im.time;
data = im.data;
clear im;

avg = mean(data);
stddev = std(data);

% set the number of standard deviations to bound the data
n = 2.7;
min_stddev = avg - n*stddev;
max_stddev = avg + n*stddev;

% remove values bounded by the min and max stddev
for ind = 1:length(data)
    if data(ind) < max_stddev && data(ind) > min_stddev
        data(ind) = 0;
    end
end

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
