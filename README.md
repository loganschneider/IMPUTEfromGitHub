# IMPUTEfromGitHub
This is a script that assembles latest imputation pipeline files from GitHub and then runs imputation on the specified QCed files

runIMPUTATIONfromGit is the updated script that employs the current (2018) SLURM job submission protocol
runIMPUTATIONfromGitSUNENGINE is the old script that employs the prior SCG Sun Engine job submission protocol

Recommendations for running:
-Create directory in which to impute (many files generated)
-Put the runIMPUTATIONfromGit.sh and the PLINK binaries (post-QC...possibly using QCnew.sh, which outputs *_NOdups_aligned.bed/bim/fam)
-When prompted to enter PLINK binary filename, enter the name without extension (e.g. *_NOdups_aligned)
