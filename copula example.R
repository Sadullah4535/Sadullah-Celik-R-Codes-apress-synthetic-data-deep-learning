# Load the "copula" and "scatterplot3d" packages.
library("copula")
library("scatterplot3d")
set.seed(300)
# In this method, an integer is selected because of pCopula().
n<-6 
# Generate of t copula.
tCopula <- tCopula(iTau(tCopula(df =n), tau = 0.6), df =5)
# Random sample selection from t copula.
X <- rCopula(1500, copula = tCopula) 
# Drawing the density graph of two-dimensional distributions. 
wireframe2(tCopula, FUN = dCopula, delta = 0.050) 

# Drawing the contour plot of the two-dimensional distribution. 
contourplot2(tCopula, FUN = pCopula)

# Contour density plot of the two-dimensional distribution.
contourplot2(tCopula, FUN = dCopula, n.grid = 40, cuts = 25)

# Plotting the scatter plot.
plot(X, xlab = quote(X[1]), ylab = quote(X[2])
      

# Normal copula generation.
nCopula <- normalCopula(iTau(normalCopula(), tau = 0.6))
# Random sampling from normal copula.
X <- rCopula(1500, copula = nCopula)
# Plotting the density of two-dimensional distributions.
wireframe2(nCopula, FUN = dCopula, delta = 0.050) 


# Drawing the contour plot of the two-dimensional distribution.
contourplot2(nCopula, FUN = pCopula)

# Contour density plot of the two-dimensional distribution.
contourplot2(nCopula, FUN = dCopula, n.grid = 44, cuts = 35, lwd = 1/4) 

# Plotting the scatter plot. You will see the graph shown in Figure 3-37.
plot(X, xlab = quote(X[1]), ylab = quote(X[2]))

# Gaussian Copula
# Two-dimensional (2-D) copula and two-variable normal object creation.
mycop<-normalCopula(c(0.82),dim=2,dispstr="ex")
mymvd<-mvdc(copula=mycop,margins =c("norm","norm"),paramMargins=list(list(mean=0,sd=1),list(mean=1,2)))
# Generating 1500 random numbers from a multivariate distribution.
r<-rMvdc(1500,mymvd)
# Calculation of density.
density<-dMvdc(r,mymvd)
# Calculation of the cumulative distribution.
distance<-pMvdc(r,mymvd)
# Visualization of the density graph in three-dimensional space.
x<-r[,1]
y<-r[,2]
scatterplot3d(x,y,density,highlight.3d = T)

# Visualization of the distance graph in three-dimensional space. 
scatterplot3d(x,y,distance,highlight.3d = T)


# Visualization of copula function
w<-rCopula(1500,mycop)
x<-w[,1]
y<-w[,2]
copdensity<-dCopula(w,mycop)
copdistance<-pCopula(w,mycop)
# Visualization of the copula density plot in three-dimensional space. 
scatterplot3d(x,y,copdensity,highlight.3d = T)


# Visualization of the copula distance graph in three-dimensional space. 
scatterplot3d(x,y,copdistance,highlight.3d = T)




