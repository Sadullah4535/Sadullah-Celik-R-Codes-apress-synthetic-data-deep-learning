install.packages("ggpubr")
# Load the “ggpubr” library
library(ggpubr)

# Store the text to be used in the analysis in an array
Text<-paste("The iris data set is a dataset consisting","of measurements of the features of","150 irises. The dataset is used to","train and test machine learning algorithms.","The training set is used to","train the machine learning algorithm,","and the test set is used to test the accuracy of","the machine learning algorithm.",sep="\n")

# Create a text grob
TextGrob <- text_grob(Text, face = "italic", color = "red")

# Draw the text
as_ggplot(TextGrob)
