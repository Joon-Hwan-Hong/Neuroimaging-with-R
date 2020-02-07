library(AnalyzeFMRI)

# *** Linear Transformation ***
linear_spline <- function(x, knots, slope){
  knots <- c(min(x), knots, max(x))
  slopeS <- slope[1]
  for (j in 2: length(slope)) {
    slopeS <- c(slopeS, slope[j]-sum(slopeS))
  }
  
  rvals <- numeric(length(x))
  for (i in 2: length(knots)) {
    rvals <- ifelse(x>= knots[i-1], slopeS[i-1]*(x-knots[i-1]) + rvals, rvals)
  }
  
  return(rvals)
}

# Linear Transformation of the brain scan image
knot.vals <- c(0.3,0.6)
slp.vals <- c(1,0.5,0.25)
dir <- paste(getwd(), "/kirby21/visit_1/113", sep="")
T1 <- readNIfTI(file.path(paste0(dir,"/SUBJ0001-01-MPRAGE.nii.gz")))
trans_T1 <- linear_spline(T1, knot.vals*max(T1), slp.vals)
image(T1, z=150, plot.type="single", main="Original Image")
image(trans_T1, z=150, plot.type="single", main="Transformed Image")


# *** Smoothing *** 
smooth_T1 <- GaussSmoothArray(T1, voxdim=c(1,1,1), ksize=11, sigma=diag(3,3), mask=NULL, var.norm=FALSE)
orthographic(smooth_T1)


# *** FLAIR (Fluid-attenuated inversion recovery) ***
# hyperintense
mridir <- paste(getwd(), "/BRAINIX/NIfTI", sep="")
sequence <- "FLAIR.nii.gz"
volume_file <- cal_img(readNIfTI(file.path(mridir, sequence), reorient=FALSE))
image(volume_file)
# Weignted imaging of T2 as an example
volume_T2 <- readNIfTI(file.path(mridir, "T2"), reorient=FALSE)
image(volume_T2)
