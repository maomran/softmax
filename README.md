# softmax
Verilog implementation of Softmax function

Softmax is an activation function usually used in Neural Networks as a logistic function for each neuron output. 
In this work, floating point is supported through ADD/Mul/Div operations for real numbers to calcualte softmax. 
Softmax is based on calculating the exponential of input vector. 
Taylo series approximation is used to calculate exponential which is donated as follow: 
    f(x) = e^x = 1 + x/1! + x^2/2! + x^3/3! + ....
    Computation of this example using simple Python code:

>>> import math
>>> z = [1.0, 2.0, 3.0, 4.0, 1.0, 2.0, 3.0]
>>> z_exp = [math.exp(i) for i in z]
>>> print([round(i, 2) for i in z_exp])
[2.72, 7.39, 20.09, 54.6, 2.72, 7.39, 20.09]
>>> sum_z_exp = sum(z_exp)
>>> print(round(sum_z_exp, 2))
114.98
>>> softmax = [round(i / sum_z_exp, 3) for i in z_exp]
>>> print(softmax)
[0.024, 0.064, 0.175, 0.475, 0.024, 0.064, 0.175]
