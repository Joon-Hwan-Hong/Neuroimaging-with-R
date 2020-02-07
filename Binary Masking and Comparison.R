library(oro.nifti)

# setting MRI directory for Kirby21 data
mridir <- paste(getwd(), "/kirby21/visit_1/113", sep="")

# TEST for reading image
T1 <- readNIfTI(file.path(paste0(mridir,"/SUBJ0001-01-MPRAGE.nii.gz")))
orthographic(T1)

# Binary Masking
mask <- readNIfTI(file.path(paste0(mridir,"/SUBJ0001_mask.nii.gz")))
orthographic(mask)
masked.T1 <- T1*mask
orthographic(masked.T1)

# comparing different samples
T1.followup <- readNIfTI(file.path(paste0(mridir,"/SUBJ0001-02-MPRAGE.nii.gz")))
subtract.T1 <- T1.followup - T1
orthographic(subtract.T1)
