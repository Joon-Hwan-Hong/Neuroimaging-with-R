library(oro.nifti)

setwd("C:\\Users\\jhong43\\Documents\\Neuroimaging-with-R\\BRAINIX\\NIfTI")
f_name =  "TEST_3D_File"
nii_T1 = readNIfTI(fname= f_name)

# ***TEST***
# Brain visualize at slice 11
image(nii_T1, z=11, plot.type="single")
# all the slides sequenaitally
image(nii_T1)
# orthographic view
orthographic(nii_T1, xyz=c(200,200,11))
# visusalizing all slices
par(mfrow=c(1,2))
o<-par(mar=c(4,4,0,0))
# histology of all intensities
hist(nii_T1, breaks=75, prob=T, xlab="T1 intensities", col=rgb(0,0,1,1/2), main="")
# histology for > 20
hist(nii_T1[nii_T1 > 20], breaks= 75, prob=T, xlab="T1 intensities > 20", col=rgb(0,0,1,1/2), main="")


# Backmapping of one slice
is_btw_300_400 <- ((nii_T1 > 300) & (nii_T1 < 400))
nii_T1_mask <- nii_T1
nii_T1_mask[!is_btw_300_400] = NA # disregard these info
overlay(nii_T1, nii_T1_mask, z=11, plot.type="single")

# Backmapping of the file
overlay(nii_T1, nii_T1_mask)

# orthographic backmapping
orthographic(nii_T1, nii_T1_mask, xyz=c(200,2,20,11), text="btw 300~400", text.cex= 1.5)
