import numpy as np 
from numpy import random
import matplotlib.pyplot as plt
# Suppose you had two 8-sided dice, 
# and your experiment is toss these two dice 25 times. 
# The random variables are the outcomes on each die from each toss. 
# Calculate the mean, standard deviation,
# and correlation of these two random variables.

np.random.seed(seed=11223)

dice_1 = random.random_integers(1, 8, 25)
dice_2 = random.random_integers(1, 8, 25)

print "The mean of dices are: ", dice_1.mean(), dice_2.mean()
print "The standard deviation of dices are: ", dice_1.std(), dice_2.std()
print "The correlation of dices is: ", np.corrcoef(dice_1, dice_2)[0, 1]


class BivariateNormal:
    def __init__(self, ss, mean, var1, var2, corr):
        """Create a new bivariate normal instance
        
        ss   Sample size of the observed data
        mean Mean zero
        corr Correlation
        """ 
        self._ss = ss
        self._mean = mean
        self._corr = corr
        self._var1 = var1
        self._var2 = var2
    
    def get_bm(self):
        """Return the Bivariate Narmal Distribution"""
        r = np.matrix([[self._var1, self._corr], [self._corr, self._var2]])
        x1, x2 = np.random.multivariate_normal(self._mean, r, self._ss).T
        return x1, x2
        
    def plot_sca(self):
        """Return Scatterplot"""
        x1, x2 = self.get_bm()
        plt.plot(x1, x2, 'bo')
        plt.xlim(-4, 4)
        plt.ylim(-4, 4)
        plt.xlabel(r'$x_1$', fontsize=16)
        plt.ylabel(r'$x_2$', fontsize=16)

    def get_mo(self):
        x1, x2 = self.get_bm()
        print "The distribution mean are:", x1.mean(), x2.mean()
        print "The distribution var are:", x1.var, x2.var()
        print "The distribution std are:", x1.std, x2.std()
        print "The distribution corrcoef is:", np.corrcoef(x1, x2)[1, 0]
        

def plot4sca():
    fig = plt.figure(figsize=(12, 10))
    ax1 = fig.add_subplot(2, 2, 1)
    m1.plot_sca()
    plt.title(r'Scatterplot of $\rho$=0', fontsize=20)
    ax2 = fig.add_subplot(2, 2, 2)
    m2.plot_sca()
    plt.title(r'Scatterplot of $\rho$=-0.5', fontsize=20)
    ax3 = fig.add_subplot(2, 2, 3)
    m3.plot_sca()
    plt.title(r'Scatterplot of $\rho$=0.8', fontsize=20)
    ax4 = fig.add_subplot(2, 2, 4)
    m4.plot_sca()
    plt.title(r'Scatterplot of $\rho$=0.99', fontsize=20)

m1 = BivariateNormal(1000, [0, 0], 1, 1, 0)
m2 = BivariateNormal(1000, [0, 0], 1, 1, -0.5)
m3 = BivariateNormal(1000, [0, 0], 1, 1, 0.8)
m4 = BivariateNormal(1000, [0, 0], 1, 1, 0.99)
plot4sca()
print "Here are the first distribution moments:"
m1.get_mo()
print "Here are the second distribution moments:"
m2.get_mo()
print "Here are the third distribution moments:"
m3.get_mo()
print "Here are the forth distribution moments:"
m4.get_mo()

m1 = BivariateNormal(10000, [0, 0], 1, 1, 0)
m2 = BivariateNormal(10000, [0, 0], 1, 1, -0.5)
m3 = BivariateNormal(10000, [0, 0], 1, 1, 0.8)
m4 = BivariateNormal(10000, [0, 0], 1, 1, 0.99)
plot4sca()
print "Here are the first distribution moments:"
m1.get_mo()
print "Here are the second distribution moments:"
m2.get_mo()
print "Here are the third distribution moments:"
m3.get_mo()
print "Here are the forth distribution moments:"
m4.get_mo()

m1 = BivariateNormal(1000, [0, 0], 3, 5, 0)
m2 = BivariateNormal(1000, [0, 0], 3, 5, -0.5)
m3 = BivariateNormal(1000, [0, 0], 3, 5, 0.8)
m4 = BivariateNormal(1000, [0, 0], 3, 5, 0.99)
plot4sca()
print "Here are the first distribution moments:"
m1.get_mo()
print "Here are the second distribution moments:"
m2.get_mo()
print "Here are the third distribution moments:"
m3.get_mo()
print "Here are the forth distribution moments:"
m4.get_mo()



 


