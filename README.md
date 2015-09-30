# Overview

This compressive sensing project is used to represent (compress) and analyze neuronal 
data, which is inherently complex. The data is taken from a primate using 
a Utah array, compact 10x10 matrices of electrical recording spikes that 
can be surgically implanted in the brain.  The main problem with neuronal data 
is its size: with just a few minutes of recording the array collects millions
of data points. 

By making certain logical assumptions about the data (namely, that the data itself is sparse),
we were able to apply l1-minimization techniques using L1 Magic, a library of functions 
for solving optimization problems like l1-minimization. These techniques allow us to 
represent, with minimal error, the original data recordings using small sample
sizes (less than 20% of the data). 

In other words, we can recreate an estimate of the original data with just 20% or 
less of the data points. This is possible because of the way neuronal signals are 
distributed: the grand majority of the points (more than 90%) are near zero because no signal is 
being recieved; then an action potenial, the spike in the signal that represents
an action in a neuron, is transmitted and the values spike drastically for a short
period of time. This is an example of the sparsity of the data and explains why
we were able to make mathematical assumptions about it. 

Once we were able to create a representation of the data, we could iterate through
the representation and make observations on the full dataset. Since the representation
was so much smaller (and had much less noise), the computational power required to iterate 
through it is much less. 

To learn more about the theory and results of this project, as well as to see figures with 
the resulting representations, take a look at the paper in this repository titled, 
"action_potential_sparsity.pdf". 

# Source Code Explanation

The Matlab code can be split up into three parts, as shown by the comments: 

(1) extract_sample_data.m: script to extract n values from the original data 
    to use further.

(2) piecewise_rec.m: calls the function "rec_pd.m" to execute the algorithm 
that reconstructs the original data from the sampled through the l1 minimization algorithm called 
the "primal-dual interior point" method.

(3) threshold.m: Sets every value that is greater than max_stddev (max standard deviation) and 
less than min_stddev (min standard deviation) from the mean of the entire data set to 0. This
clears up the noise and retains the actual signal noise.

