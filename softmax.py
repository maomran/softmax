
import math
z = [1.0,1 ,1, 1.0]
z_exp = [math.exp(i) for i in z]
print([round(i, 2) for i in z_exp])
sum_z_exp = sum(z_exp)
print(round(sum_z_exp, 2))

softmax = [round(i / sum_z_exp, 3) for i in z_exp]
print(softmax)
