# Pharmacological Modulation of Functional Brain Connectivity in Autism

This repository contains resting-state functional MRI (rs-fMRI) data and analysis scripts from our pharmacological study examining the effects of the µ-opioid receptor agonist tianeptine on weighted Degree Centrality (wDC). Specifically, we investigated whether tianeptine modulates sensorimotor and frontoparietal functional connectivity in autistic and non-autistic adults.

In the study, participants underwent two scanning sessions in a placebo-controlled, double-blind, crossover design. We employed multi-echo (ME) ICA denoising and a processing pipeline adapted from Holiga et al. (2019) to derive voxel-wise wDC. The data include:
- Preprocessed rs-fMRI images (after ME-ICA and standard AFNI-based corrections)
- Quality-control measures (e.g., framewise displacement [FD])
- Final wDC maps constrained to the sensorimotor and frontoparietal regions previously identified in a large, multisite autism study (Holiga et al., 2019)

Subjects exceeding a motion threshold ([TODO] FD > 3 mm ??? see comments on text) or exhibiting other quality-control issues (e.g., excessive artefacts) were excluded. The resultant sample includes 19 non-autistic and 20 autistic adults, each scanned under placebo and tianeptine conditions.

Detailed steps for the analyses—such as the multi-echo ICA denoising, regression of nuisance signals, correlation thresholding, computation of wDC, and linear mixed-effects modeling—are provided in the accompanying scripts. We used AFNI (Cox, 1996) and Python (NumPy, SciPy, NiBabel, Nilearn) for preprocessing and connectivity estimation.


## Running

To estimate resting-state functional brain connectivity (FC) from fMRI images and extract graph features. Assess the effect of various drugs on FC and graph properties.

1. Pre-processing:

- Extract the DICOM images from the TAR archive and convert them to NIfTI (using SGE) - *untar_dcm2nii_final.csh* 
- Generate the script for the [AFNI-based](https://www.sciencedirect.com/science/article/pii/S0010480996900142) pre-processing ``afni_multi-echo.rtf`` (the output file, i.e. proc.SUBJ, should be modified as per the instructions in the rtf file and then run using:
``tcsh -xef proc.SUBJ | \& tee output.proc.SUBJ``

2. Functional Connectivity Estimation:
 
 - Compute FC and (static) weighted degree centrality (wDC) ``voxel_wise_FC_calc.ipynb`` and ``z-score.ipynb``

3. Post-processing:

- Resample and binarise the Holiga et al. [EU-AIMS masks](https://www.science.org/doi/10.1126/scitranslmed.aat9223)
- Intersect each with the intersection mask generated using the grey matter masks from all participants (all sessions) ``generate_intersection_mask.ipynb``
- Estimate mask-averaged values for each mask for each participant session:``generate_mean_DC.ipynb``

4. Statistical analysis and plotting:

- Check if the study groups are balanced in terms of age, IQ and in-scanner movement as well as depression and anxiety scores: ``balance_check.ipynb``
- Mask-averaged wDC analyses: ``mean_wDC_LMM.R``
- Individual wDC trajectories: ``spaghetti_individual_trajectories.R``


## Dataset 

[TODO] Blah blah

## Code 

The conda environment file required is ``wDC.yml``. Several [fslmaths](https://www.sciencedirect.com/science/article/pii/S1053811911010603) commands have been used to additionally manipulate images, e.g. to threshold, binarise or resample images.

## Licence

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## References

[TODO] Add references