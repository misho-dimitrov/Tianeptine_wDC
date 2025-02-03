# Pharmacological Modulation of Functional Brain Connectivity in Autism

## Estimate resting-state functional brain connectivity (FC) from fMRI images and extract graph features. <br /> Assess the effect of various drugs on FC and graph properties.

### Main Scripts and Commands: 

<ins>Pre-processing:</ins> <br />
A) Extract the DICOM images from the TAR archive and convert them to NIfTI (using SGE) - *untar_dcm2nii_final.csh* <br />
B) Generate the script for the AFNI-based pre-processing (https://www.sciencedirect.com/science/article/pii/S0010480996900142) - *afni_multi-echo.rtf* (the output file, i.e. proc.SUBJ, should be modified as per the instructions in the rtf file and then run using *tcsh -xef proc.SUBJ | \& tee output.proc.SUBJ*) <br />

<ins>Functional Connectivity Estimation:</ins> <br />
C) Compute FC and (static) weighted degree centrality (wDC) - *voxel_wise_FC_calc.ipynb* and *z-score.ipynb* <br />

<ins>Post-processing:</ins> <br />
D) Resample and binarise the Holiga et al. EU-AIMS masks (https://www.science.org/doi/10.1126/scitranslmed.aat9223), and intersect each with the intersection mask generated using the grey matter masks from all participants (all sessions) - *generate_intersection_mask.ipynb*; Estimate mask-averaged values for each mask for each participant session - *generate_mean_DC.ipynb* <br />

<ins>Statistical analysis and plotting:</ins> <br />
E) Check if the study groups are balanced in terms of age, IQ and in-scanner movement as well as depression and anxiety scores - *balance_check.ipynb* <br />

F) Mask-averaged wDC analyses - *mean_wDC_LMM.R* <br />
G) Individual wDC trajectories - *spaghetti_individual_trajectories.R* <br />

<ins>*Several fslmaths (FSL - https://www.sciencedirect.com/science/article/pii/S1053811911010603) commands have been used to additionally manipulate images, e.g. to threshold, binarise or resample images.* </ins>

<ins>*N.B. conda environment file: wDC.yml*</ins>
