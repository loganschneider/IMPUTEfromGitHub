#!/bin/sh

#This script will download the latest version of the imputation pipeline and then run it
#Put this script in the directory that has the PLINK binaries to impute:
#	rsync -aq /srv/gsfs0/projects/mignot/GWAS_scripts/runIMPUTATIONfromGit.sh /path/to/directory/containing/PLINKbinaries
#Navigate to the directory that has the PLINK binaries for imputation

echo "Enter name of PLINK binaries without bed/bim/fam extension (e.g. Affy_NOdups_aligned), followed by [ENTER]: "
read binaries

workdir=$PWD

#Bring in shapeit and impute2 compiled libraries if not already present
if [ ! -f $workdir/shapeit ]
then
	rsync -aq /srv/gsfs0/projects/mignot/PLMGWAS/shapeit .
	echo "shapeit library not found...so bringing it over"
fi
if [ ! -f $workdir/impute2 ]
then
	rsync -aq /srv/gsfs0/projects/mignot/PLMGWAS/impute2 .
	echo "impute2 library not found...so bringing it over"
fi


#Download or update the git repository
if [ -d "IMPUTE-PIPELINE-MIGNOT-LAB" ]
then
	echo "Will get the latest Github update of IMPUTE-PIPELINE-MIGNOT-LAB"
	rm -rf $workdir/IMPUTE-PIPELINE-MIGNOT-LAB
	git clone https://github.com/adiamb/IMPUTE-PIPELINE-MIGNOT-LAB.git
	find IMPUTE-PIPELINE-MIGNOT-LAB -type d -exec chmod 777 {} \;
else
	echo "Downloading latest commit of the pipeline"
	git clone https://github.com/adiamb/IMPUTE-PIPELINE-MIGNOT-LAB.git
	find IMPUTE-PIPELINE-MIGNOT-LAB -type d -exec chmod 777 {} \;
fi

#Change permissions on all files in pipeline
find IMPUTE-PIPELINE-MIGNOT-LAB -type f -exec chmod 777 {} \;

#Copy imputation pipeline files into current working directory that contains the PLINK binaries to be imputed
yes | cp -a IMPUTE-PIPELINE-MIGNOT-LAB/* $workdir

impute="$(find . -maxdepth 1 -name "IMPUTE_PIPELINE*")"
$impute $binaries