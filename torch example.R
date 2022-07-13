
install.packages("torchvision")
install.packages("magick")
library(torchvision)
library(magick)

##https://www.kaggle.com/datasets/vishalsubbiah/pokemon-images-and-types


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



geometry = geometry_area(400, 200)
image_montage(image_grid, tile = '2', geometry = geometry)




tiny_imagenet_dataset("images", download = T)

# Upload the images from the folder we just downloaded.
dataset = image_folder_dataset("images")

# Create the dataloader
imagenes_dataloader = dataloader(dataset , batch_size =  10, shuffle = T)

# Save batches
batch = imagenes_dataloader$.iter()$.next()

# Visualize the first batch size
batch[[1]]$size()








































