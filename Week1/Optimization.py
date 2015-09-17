# Optimization Homework
# Let $f(x_1,x_2)=x_1^2-x_2^2$
# Graph $f(x)$ over a relevant domain using R or Python.  
# Find all critical points and determine their nature 
# both by hand and by using R or Python.  

## 
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import seaborn as sns
sns.set(context='notebook', style='whitegrid', palette='deep', 
        font='sans-serif', font_scale=1, rc=None)
from mpl_toolkits.mplot3d import Axes3D
from scipy.optimize import minimize

## Optimization f(x) = x1 ^2 -x2 ^2
x1 = np.linspace(-10,10,100)
x2 = np.linspace(-10,10,100)
x1, x2 = np.meshgrid(x1, x2)
f = x1**2 - x2**2
        
fig = plt.figure(figsize = (6, 5))
ax = Axes3D(fig)
ax.plot_wireframe(x1, x2, f, rstride=4, cstride=4, color='#AD5300')
ax.view_init(20,50)
ax.set_xlabel(r'$x_1$', fontsize = 16)
ax.set_ylabel(r'$x_2$', fontsize = 16)
ax.set_zlabel(r'$f(x_1, x_2)$', fontsize = 16)
plt.show()

def func(params, sign=1.0):
    x1, x2 = params
    return sign*(x1**2 - x2**2)

minimize(func, [-10.0, 10.0], args=(1.0,), method='BFGS',
         options={'disp': True})