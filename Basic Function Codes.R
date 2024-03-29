# Concatenate into a vector
a=c(3,4,6,2,1)
b=c(6,3,2,8,9, a)
b
# Create an increasing array from 7 to 14 with an interval of 1.4
seq(from=7, to=14,by=1.4)
# Create a sequence that repeats 7 5 times
rep(7,times=5)
# Define a vector y that can take a value between 4 and 20.
y<-4:20
y
# A random permutation
sample(y)
# Bootstrap resampling 
sample(y,replace=TRUE)
# Bernoulli trials
sample(c(3,7),10,replace=TRUE)

# Creating a Value Vector from a Known Univariate Distribution
set.seed(12)
# Select sample number as 15
n=15 
# Uniform distribution btw 5 and 30
runif(n, min=5, max=30)
# A Gaussian distribution has a mean of 3 and a standard deviation of 1.5.
rnorm(n, mean=3, sd=1.5)
# The parameter lambda is used to determine the shape of the Poisson distribution.
rpois(n, lambda=3)
# Exponential distribution 
rexp(n, rate=2)
# Binomial distribution 
rbinom(n, size=5, prob=0.5)
# lognormal distribution 
rlnorm(n, meanlog=2, sdlog=1.5)

#Vector Generation from a Multi-levels Categorical Variable
# Generating a random sequence from a four-level categorical variable.
sample(c("G-1","G-2","G-3","G-4"),8,replace=TRUE)
# A five-level categorical variable can be used to generate a random sequence.
sample(c("G-1","G-2","G-3","G-4","G-5"),10,replace=TRUE)

#Multivariate 
# Generate a data.frame from 4 different samples, each with 5 different variables from the same distribution.
data.frame(indv=factor(paste("S-", 1:4, sep = "")), matrix(rnorm(4*5, 4, 2), ncol = 5))
# Generate a data.frame with 3 independent variables from 4 different distributions.
data.frame(indv=factor(paste("S-", 1:4, sep = "")), W1=rnorm(4, mean=3,sd=2), W2=rnorm(4,mean=5, sd=3), W3=rpois(4,lambda=5))
# Generate data.frame 
data.frame(indv=factor(paste("S-", 1:8, sep = "")), W1=rnorm(8, mean=1,sd=2), W2=rnorm(8,mean=10, sd=4), W3=rnorm(8,mean=5,sd=3), Animal=sample(c("Cat","Dog"),8, replace=TRUE))

Multivariate (with correlation)
library(MASS)
library(psych)
library(rgl)
set.seed(50)
m <- 3
n <- 1000
sigma <- matrix(c(1, -0.4, 0.3, -0.8, 1, 0.6, -0.7, 0.2, 1), nrow=3)
X <- mvrnorm(n, mu=rep(0, m),Sigma=sigma,empirical=T)
colnames(X) <- paste0("X", 1:m)
cor(X,method='spearman') 
# Compare variables
pairs.panels(X)
# Normalize the variables
w <- pnorm(X)
# Compare normalized variables
pairs.panels(w)
# Draw the representation of variables in 3D space using the "rgl" package.
plot3d(w[,1],w[,2],w[,3],pch=30,col='black')

# Create variables u1, u2 and u3
u1 <- qt(w[,1],df=5)
u2<-qgamma(w[,2],shape=2,scale=1)
u3 <- qbeta(w[,3],3,3)

# Draw a graph for the variables u1, u2, and u3 in a 3-dimensional space
plot3d(u1,u2,u3,pch=20,col='blue')
# Creates a data frame using the simulated variables u1, u2, and u3.
data.frame<-cbind(u1,u2,u3)

# Print Spearman correlation matrix of variables
cor(data.frame,meth='spearman')
pairs.panels(data.frame)

