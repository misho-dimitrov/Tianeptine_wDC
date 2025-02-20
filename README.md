# Pharmacological Modulation of Functional Brain Connectivity in Autism

This repository contains processing and analysis scripts from our pharmacological study examining the effects of the µ-opioid receptor agonist tianeptine on weighted Degree Centrality (wDC). Specifically, we investigated whether tianeptine modulates sensorimotor and frontoparietal functional connectivity (indexed by wDC) in autistic and non-autistic adults.

In the study, participants underwent two scanning sessions in a randomised, placebo-controlled, double-blind, crossover design. The final sample consists of 19 non-autistic and 20 autistic adults. We employed multi-echo (ME) ICA denoising and a processing pipeline adapted from [Holiga et al., 2019](https://www.science.org/doi/10.1126/scitranslmed.aat9223) to derive voxel-wise wDC. 

Detailed steps for the analyses—such as the multi-echo ICA denoising, regression of nuisance signals, correlation thresholding, computation of wDC, and linear mixed-effects modeling—are provided below and in the accompanying scripts. We used Unix scripting, [AFNI (Cox, 1996)](https://www.sciencedirect.com/science/article/pii/S0010480996900142), [FSL (Jenkinson et al., 2012)](https://www.sciencedirect.com/science/article/pii/S1053811911010603), Python (pandas, NumPy, matplotlib, SciPy, Scikit-learn, NiBabel, Nilearn, graph-tool) and R (base, p-testR, ggplot2, tidyr, ggpubr and readr) for processing, functional connectivity estimation, statistical analysis and visualisation of results.


## Running

To estimate resting-state functional brain connectivity (FC) from fMRI images and extract graph features. Assess the effect of a drug on FC and graph properties.

1. Pre-processing:

- Extract the DICOM images from the TAR archive and convert them to NIfTI (using SGE) - *untar_dcm2nii_final.csh* 
- Generate the script for the [AFNI-based](https://www.sciencedirect.com/science/article/pii/S0010480996900142) pre-processing ``afni_multi-echo.rtf`` (the output file, i.e. proc.SUBJ, should be modified as per the instructions in the rtf file and then run using:
``tcsh -xef proc.SUBJ | \& tee output.proc.SUBJ``

2. Functional Connectivity Estimation:
 
 - Compute FC and (static) weighted degree centrality (wDC) ``voxel_wise_FC_calc.ipynb`` and ``z-score.ipynb``

3. Post-processing:

- Resample and binarise the [Holiga et al. EU-AIMS masks](https://www.science.org/doi/10.1126/scitranslmed.aat9223) using FSL [fslmaths](https://www.sciencedirect.com/science/article/pii/S1053811911010603)
- Intersect each with the intersection mask generated using the grey matter masks from all participants (all sessions) ``generate_intersection_mask.ipynb``
- Estimate mask-averaged values for each mask for each participant session:``generate_mean_DC.ipynb``

4. Statistical analysis and plotting:

- Check if the study groups are balanced in terms of age, IQ and in-scanner movement: ``balance_check.ipynb``
- Mask-averaged wDC analyses: ``mean_wDC_LMM.R``
- Individual wDC trajectories: ``spaghetti_individual_trajectories.R``

__N.B. The conda environment file required is ``wDC.yml``.__

## Licence

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## References

Holiga Š, Hipp JF, Chatham CH, Garces P, Spooren W, D’Ardhuy XL et al. [Patients with autism spectrum disorders display reproducible functional connectivity alterations.](https://www.science.org/doi/10.1126/scitranslmed.aat9223) Science Translational Medicine 2019; 11(481).

Cox RW. [AFNI: Software for Analysis and Visualization of Functional Magnetic Resonance Neuroimages.](https://www.sciencedirect.com/science/article/pii/S0010480996900142) Computers and Biomedical Research 1996; 29(3): 162-173.

Jenkinson M, Beckmann CF, Behrens TE, Woolrich MW, Smith SM. [Fsl.](https://www.sciencedirect.com/science/article/pii/S1053811911010603) Neuroimage 2012; 62(2): 782-790.