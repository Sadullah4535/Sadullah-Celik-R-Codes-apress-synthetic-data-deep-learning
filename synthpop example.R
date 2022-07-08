# Load the "synthpop","tidyverse","sampling" and "partykit" packages.
library(synthpop)
library(tidyverse)
library(sampling)
library(partykit)
cols <- c("magenta", "green")
options(xtable.floating = FALSE)
options(xtable.timestamp = "")
my.seed<-235
# Select the number of samples to be used in the analysis.
n<-200
# Simulate a random data frame with 200 samples
data <- data.frame(sex =  sample (c("F","M")), age = rnorm(n,18:70), educ = sample(c("primary","secondary","bachelor","master","doctor")), bmi = rnorm(n,20:30),chol = rnorm(n,60:400), sbp = rnorm(n, 40:180), dbp = rnorm(n, 40:180), weight = rnorm(n,45:120), smoke = rep(c("yes","no")), martial =  sample (c("married","singel")), income=rnorm(n,500:7000))
# Print the first 6 lines of the simulate a rondom data
head(data)
# Open the “missForest” package 
library(missForest)
# Simulate a random data frame with missing values  
# Generate 5% missing values at random
Data.mis <- prodNA(data, noNA = 0.05)
# Print the first 6 lines of the missing data
head(Data.mis)

# Synthesize data.
Synthesis <- syn(Data.mis, seed=my.seed)
Synthesis

# Compare the synthesized data using the "compare" function.
compare(Synthesis, Data.mis, nrow = 3, ncol = 4, cols = cols)$plot

# Choose the variables.
ods1 <- Data.mis[ , c("age", "bmi", "weight", "sbp", "income")]
syn1 <- syn(ods1, cont.na = list(income=-6))

# Compare data distributions using the Histogram Similarity method.
compare(syn1$syn, ods1, vars = "bmi")

# Selecting variables.
ods2 <- Data.mis[ , c("age", "bmi", "weight", "dbp", "income")]
syn2 <- syn(ods2, cont.na = list(bmi=-6))
sds2 <- syn(ods2, method = "ctree", m = 6)

# Compare data distributions using the Histogram Similarity method.
compare(sds2, ods2, vars = "weight", msel = 1:3)


# Compare the data distributions produced for the “income” variable with the Histogram Similarity method.
compare(syn2$syn, ods2, vars = "income", cont.na = list(income = -6), stat = "counts", table = TRUE, breaks = 10)

#Selecting and synthesize the variables.
vars3 <- c("sex", "age", "educ", "income", "smoke")
ods3 <- na.omit(Data.mis[1:500, vars3])
syn3 <- syn(ods3)

# Compare the original data with the synthetic data using the Future Importance method.
multi.compare(syn3, ods3, var = "sex", by = c("educ"))

# Compare the original data with the synthetic data using the Future Importance method.
# Multiple comparison
multi.compare(syn3, ods3, var = "smoke", by = c("sex","educ"))

# Multiple comparison using the Histogram Similarity method.
multi.compare(syn3, ods3, var = "age", by = c("sex", "educ"), y.hist = "density", binwidth = 5)

# Multiple comparison using boxplot.
multi.compare(syn3, ods3, var = "age", by = c("sex", "educ"), cont.type = "boxplot")
multi.compare(syn3, ods3, var = "income", by = c("smoke"), cont.type = "boxplot")

# Example: Linear model
# Compare model estimates based on synthesized and observed data
# Select variables
ods4 <- Data.mis[,c("age","bmi","chol","sbp", "dbp", "weight", "income")]
ods4$income[ods4$income == -8] <- NA
syn4 <- syn(ods4, m = 3)
f1 <- lm.synds(income ~ age + bmi + sbp + dbp, data = syn4)
f1
print(f1, msel = 1:3)
summary(f1)

# Compare model estimates based on synthesised and observed data
compare(f1, ods4, lcol=cols)

# Example: Multi-comparison model
# Select the variables to use in the model
ods5 <- Data.mis[1:500, c("sex", "age", "educ", "bmi", "martial", "smoke")]
syn5 <- syn(ods5, m = 4)


# Multi-modelling
f2 <- multinom.synds(educ ~ sex + age, data = syn5)
summary(f2)
print(f2, msel = 1:3)

# Comparing synthetic and observed data. 
compare(f2, ods5, print.coef = TRUE, plot = "coef", lcol=cols)


