library(oro.dicom)
library(oro.nifti)

# hard coded directory and extract dicoms
setwd("C:\\Users\\jhong43\\Documents\\Neuroimaging-with-R\\BRAINIX\\DICOM")
all_slices_T1 = readDICOM("T1\\")

# to NifTI file
nii_T1 = dicom2nifti(all_slices_T1)

# write and read NifTI files
setwd("C:\\Users\\jhong43\\Documents\\Neuroimaging-with-R\\BRAINIX\\NIfTI")
f_name = "TEST_3D_File"
writeNIfTI(nim=nii_T1, filename=f_name)

nii_T2 = readNIfTI("T2.nii.gz", reorient= FALSE)


