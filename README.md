# sparse-representation
An application of L1-minimization used to represent sparse neural data. 

This compressive sensing project is used to represent and analyze neuronal 
data, which is inherently complex. The data is taken from a primate using 
a Utah array, compact 10x10 matrices of electrical recording spikes that 
can be surgically implanted in the brain.  The main problem with neuronal data 
is its size: with just a few minutes of recording the array collects millions
of data points. 

By making certain logical assumptions about the data, we were able to apply
l1-minimization techniques using L1 Magic, a library of functions for solving
optimization problems like l1-minimization. These techniques allow us to 
represent, with minimal error, the original data recordings using small sample
sizes (less than 20% of the data). 

Once we were able to create a representation of the data, we could iterate through
the representation and make observations on the full dataset. Since the representation
was so much smaller, the computational power required to iterate through it is much less. 

To learn more about the theory and results of this project, take a look at the paper in 
this repository titled, "action_potential_sparsity.pdf". 

# Source code description


