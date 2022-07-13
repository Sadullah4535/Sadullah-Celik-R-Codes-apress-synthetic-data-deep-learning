install.packages("dplyr")
library(dplyr)
wine_new = read.csv("C:/Users/....../wine.csv")
wine_new$id = as.character(seq(1, nrow(wine_new)))
head(wine_new)

wine_new.label = mutate( wine_new, label1 = quality == '0', label2 = quality == '1', quality = factor(quality) )
sapply(wine_new.label, class)

feature.names = colnames(wine_new)[!(colnames(wine_new) %in% c('id', 'quality', 'label1', 'label2'))]
numeric = sapply(wine_new.label, is.numeric)
wine_new.scaled = wine_new.label
wine_new.scaled[ ,numeric]= sapply(wine_new.label[,numeric], scale)
head(wine_new.scaled)



train.sample = sample(wine_new$id, 500)
test.sample = wine$id[!(wine_new$id %in% train.sample)]
wine_new.train = wine_new.scaled[train.sample, ]
wine_new.test = wine_new.scaled[test.sample, ]
nnet.formula = as.formula(paste('quality ~', paste(feature.names, collapse = ' + ')))
print(nnet.formula)


install.packages("nnet")
install.packages("neuralnet")
library(nnet)
library(neuralnet)
nnet.model = nnet(nnet.formula, data = wine_new.train, size =5)
head(predict(nnet.model))

# Note that the left side of the formula is different for the two packages 
neuralnet_formula = paste( 'label1 + label2~', paste(feature.names, collapse = ' + '))
print(neuralnet_formula)

neuralnet.model = neuralnet(  neuralnet_formula, data = wine_new.train,   hidden = c(5), linear.output = FALSE)
print(head(neuralnet.model$net.result[[1]]))
plot(neuralnet.model)