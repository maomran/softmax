# softmax
Verilog implementation of Softmax function

Softmax is an activation function usually used in Neural Networks as a logistic function for each neuron output. 
In this work, floating point is supported through ADD/Mul/Div operations for real numbers to calcualte softmax. 
Softmax is based on calculating the exponential of input vector. 
Taylo series approximation is used to calculate exponential which is donated as follow: 
    f(x) = e^x = 1 + x/1! + x^2/2! + x^3/3! + ....

