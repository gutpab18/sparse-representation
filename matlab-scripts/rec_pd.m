function [ xprec ] = rec_pd( x, samp, iter )
%{
Name: rec_pd.m
Author: Vidhu Nath, Pablo Gutierrez, Alexandros Kontogiorgos-Heintz, Peter LaFontaine

Inputs:
    x - array to be minimized
    samp - size of the extracted data from the original
    iter - number of iterations through primal-dual method

Outputs:
    xprec - recovered data

NOTE: This function calls the l1eq_pd function, orignally from l1-magic.

%}

% transpose original data matrix to allow for 
x = x';

% length of data
N = length(x);

% number of random samples
K = N*samp;

% generate random A
% first get b
b = dftmtx(N);
binv = inv(b);

% take DFT of the signal
xf=b*x';

% create measurement matrix ofrandom values A
A = randn(K,N);
A = orth(A')';

% take random time measurements
y = (A*xf);

% calculate initial guess
x0 = A'*y;

% function call to the primal-dual interior point function
xp = l1eq_pd(x0,A,[],y, 1e-03, iter);

% recovered signal in time domain
xprec = real(binv * xp);

clear A K N b binv n q xf y x x0 xp;
end

%eof

