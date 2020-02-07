library(oro.dicom)

# set work directory (hard coded)
setwd("C:\\Users\\jhong43\\Documents\\Neuroimaging-with-R\\BRAINIX\\DICOM\\FLAIR")
slice = readDICOM("IM-0001-0011.dcm")

# transposing data matrix for visualization
d = dim(t(slice$img[[1]]))
image(1:d[1],1:d[2],t(slice$img[[1]]), col=gray(0:64/64))

# density histogram of the brain slice image
hist(slice$img[[1]][,], breaks=50, xlab="FLAIR", prob=T, col=rgb(0,0,1,1/4), main="")

# example of loading multiple DICOM files
setwd("C:\\Users\\jhong43\\Documents\\Neuroimaging-with-R\\BRAINIX\\DICOM")
all_slices_T1 = readDICOM("T1\\")