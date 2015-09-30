%{
Name: extract_sample_data.m
Author: Vidhu Nath, Pablo Gutierrez, Alexandros Kontogiorgos-Heintz, Peter LaFontaine
Purpose: This script opens 'Pogo-Experiment2-Session1-09-12-2013-SPKC01'
    and extracts the first 100,000 data points as sample data, since the
    original file is too large to manipulate.
%}

% clear up memory
clear;

cd('C:\code\MATLAB\CS_591_C1\');

disp('Importing original data...');
pogo1 = importdata('Pogo_SPKC01.mat');

disp('Extracting sample data...');
n = 250000;
datas = pogo1.data(1:n);
times = pogo1.time(1:n);

clear pogo1 n ans;

disp('Saving extracted data...');
original.time = times;
original.data = datas;
save original.mat original;

fprintf('Finished "extract_sample_data" execution.\n');

%eof
