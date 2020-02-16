library(oro.nifti)
library(scales)


# bias correction
bias_correct <- function(wd, file_name, reori=FALSE) {
  setwd(wd)
  nim = readNIfTI(file_name, reorient=reori)
  return(fsl_biascorrect(nim, retimg=TRUE))
}


# original-bias field correction
subtracted_img <- function(nim, nim_fast_img) {
  # quantile the diff img, this is done to get colouring of image for plotting
  sub.bias <- niftiarr(nim, nim_fast_img)
  quant = quantile(sub.bias[sub.bias != 0], probs=seq(0,1,by=0.1))
  
  # create diverging gradient palette
  fcol = div_gradient_pal(low="blue", mid="yellow", high="red")
  
  # now work
  result = ortho2(nim, sub.bias, col.y = alpha(fcol(seq(0,1, length=10)), 0.5),
                  ybreaks=quant, ycolorbar=TRUE,
                  text=paste0("Original Image Minus N4", "\n Bias-Corrected Image"))
  
  return(result)
}



# Histogram of correction
histo_example <- function(nim, fast_img) {
  #arbitrary slices
  slices = c(2,6,10,14,18)
  vals = lapply(slices, function(x) {
    cbind(img= c(nim[,,x]), fast=c(fast_img[,,x]), slice=x)
  })
  
  # vals work
  vals = do.call("rbind", vals)
  vals = data.frame(vals)
  vals = vals[ vals$img > 0 & vals$fast > 0, ]
  colnames(vals)[1:2] = c("Original Value", "Bias-Corrected Value")
  VV = melt(vals, id.vars="slice")
  
  # this one I had to use stackO for help ** refer back to it if I forget
  GG = ggplot(aes(x=value, colour=factor(slice)), data=v) + geom_line(stat="density") + facet_wrap(~ variable)
  GG = GG + scale_colour_discrete(name="Slice $")
}


# The following uses FSLR, an interface package with "FSL" neuroimaging software.
# hard coded path, I am using a linux virtual environment with fsl installed
if (have.fsl() = FALSE) {
  options(fsl.path= "/user/local/fsl")
}

# set up
setwd("/home/fsluser/Desktop/kirby21/visit_1/113")
nim = readNIfTI("113-01-MPRAGE.nii.gz", reorient=FALSE)

# bias correction and subtracted image & histogram comparison
fast_img = bias_correct("/home/fsluser/Desktop/kirby21/visit_1/113", "113-01-MPRAGE.nii.gz")
sub_image = subtracted_img(nim, fast_img)
histo_example(nim, fast_img)

