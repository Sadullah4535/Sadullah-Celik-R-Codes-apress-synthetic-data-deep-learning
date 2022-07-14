# Install torch package
install.packages("torch")
# Load the torch library
library(torch)
# Create a 4x5 random array between 1 and 0.
torch_rand(4,5)
torch_tensor
# We can convert any matrix to tensor
x_mat= matrix(c(3,6,1,4,7,9,6,1,4), nrow=3, byrow=TRUE)
tensor_1=torch_tensor(x_mat)
tensor_1
# Convert back to R object
my_array=as_array(tensor_1)
my_array

model = model = nn_sequential( # Layer 1
  nn_linear(13, 20),
  nn_relu(), 

  # Layer 2
  nn_linear(20, 35),
  nn_relu(),

  # Layer 3
  nn_linear(35,10),
  nn_softmax(2)
) 


wine = read.csv('https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data')
train_split = 0.75
sample_indices =sample(nrow(wine) * train_split)
# 2. Convert our input data to matrices and labels to vectors.
x_train = as.matrix(wine[sample_indices, -1])
y_train = as.numeric(wine[sample_indices, 1])
x_test = as.matrix(wine[-sample_indices, -1])
y_test = as.numeric(wine[-sample_indices, 1])
# 3. Convert our input data and labels into tensors.
x_train = torch_tensor(x_train, dtype = torch_float())
y_train = torch_tensor(y_train, dtype = torch_long())
x_test = torch_tensor(x_test, dtype = torch_float())
y_test = torch_tensor(y_test, dtype = torch_long())
pred_temp = model(x_train)

cat(
  " Dimensions Prediction: ", pred_temp$shape," - Object type Prediction: ", as.character(pred_temp$dtype), "\n",
  "Dimensions Label: ", y_train$shape," - Object type Label: ", as.character(y_train$dtype)
  )


library(torchvision)
library(magick)

##https://www.kaggle.com/datasets/vishalsubbiah/pokemon-images-and-types # image address

url_imagen = "C:/Users/....../archeops.png"
imagen = image_read(url_imagen)
plot(imagen)
title(main = "Original image")
par (mfrow=c(2,2))
img_width = image_info(imagen)$width
img_height = image_info(imagen)$height
imagen_crop = transform_crop(imagen,0,0, img_height/3, img_width/3)
plot(imagen_crop)
title(main = "Croped image")
imagen_crop_center = transform_center_crop(imagen, c(img_height/2, img_width/2))
plot(imagen_crop_center)
title(main = "Croped center image")
imagen_resize = transform_resize(imagen, c(img_height/5, img_width/5))
plot(imagen_resize )
title(main="Resized image")
imagen_flip = transform_hflip(imagen)
plot(imagen_flip)
title(main="Flipped image")







