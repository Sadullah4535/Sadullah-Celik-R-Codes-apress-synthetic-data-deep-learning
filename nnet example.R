# Read dataset
library(readxl)
glass <- read_excel("C:/Users/........./glass.xls")
# Generate an ID number for each column in the dataset 
glass$id = as.character(seq(1, nrow(glass)))
head(glass)
glass.label = mutate( glass, label1 = Type.of.glass== '1', label2 =Type.of.glass== '2', label3 = Type.of.glass== '3', label4 =Type.of.glass== '4',label5 = Type.of.glass== '5', label6 =Type.of.glass== '6',label7 = Type.of.glass== '7',Type.of.glass = factor(Type.of.glass) )
sapply(glass.label, class)
feature.names = colnames(glass)[!(colnames(glass) %in% c('id','Id.number' ,'Type.of.glass', 'label1', 'label2','label3', 'label4','label5', 'label6','label7'))]
# Test whether each variable in the dataset “glass.label” is a numeric value.  
numeric = sapply(glass.label, is.numeric)
numeric
glass.scaled = glass.label
# Scale the dataset 
glass.scaled[ ,numeric]= sapply(glass.label[,numeric], scale)
# Print the first six lines of the scaled dataset. 
head(glass.scaled)
# Generate a training dataset by randomly selecting 60 samples in the “id" variable  
train.sample = sample(glass$id,60)
# Create a test sample based on the training sample
test.sample = glass$id[!(glass$id %in% train.sample)]

# Scale the "train.sample" dataset
glass.train = glass.scaled[train.sample, ]
# Scale the "test.sample" dataset
glass.test = glass.scaled[test.sample, ]

# Create a regression model with a dependent variable "Type.of.glass" 
nnet.formula = as.formula(paste('Type.of.glass~', paste(feature.names, collapse = ' + ')))
# Print the generated regression model  
print(nnet.formula)
# Upload the “nnet” and “neuralnet” libraries to the existing R session to train neural networks.
library(nnet)
library(neuralnet)
nnet.model = nnet(nnet.formula, data = glass.train, size =5)
nnet.model
head(predict(nnet.model))
# Note that the left side of the formula is different for the two packages 
neuralnet_formula = paste('label1 + label2+label3 + label4+label5 + label6+label7~', paste(feature.names, collapse = ' + '))
# Print the formula used in modeling the neural network
print(neuralnet_formula)
neuralnet.model = neuralnet(  neuralnet_formula, data = glass.train,   hidden = c(5), linear.output = FALSE)
  
# Print the output results of the neural network model
print(head(neuralnet.model$net.result[[1]]))
plot(neuralnet.model)
