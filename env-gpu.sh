#!/bin/bash
# - load necessary lmod modules 
# - activate python venv ${PROJECT_DIR}/.venv/${VENV}, create it first if it does not exist. 

# newgrp gpr_compute_explor_2022_005
umask 0007

if [[ "$VIRTUAL_ENV" != "" ]]
then
    deactivate
fi

# environment variables:
VENV='gpu'
export PROJECT_DIR=$VSC_SCRATCH_PROJECTS_BASE/explor_2022_005
export SLURM_ACCOUNT='explor_2022_005'

# load lmod modules
module --force purge                                || return 1
module load cluster/dodrio/gpu_rome_a100            || return 1
module load PyTorch/1.10.0-foss-2021a-CUDA-11.3.1   || return 1
module load matplotlib/3.4.2-foss-2021a             || return 1
module load h5py/3.2.1-foss-2021a                   || return 1
module load vsc-mympirun/5.2.11                     || return 1 
# remove Pillow package. we need a more recent version as a dependency of imageio
module unload Pillow/8.2.0-GCCcore-10.3.0           || return 1
#inform the user about the loaded modules
ml

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Create the virtual environment if it does not already exists
mkdir -p ${PROJECT_DIR}/.venv
# cd ${PROJECT_DIR}/.venv
if [ -d "${PROJECT_DIR}/.venv/${VENV}" ]
then
    echo -e "${GREEN}Virtual environment '${PROJECT_DIR}/.venv/${VENV}' exists.${NC}"
else 
    echo -e "${GREEN}Virtual environment '${PROJECT_DIR}/.venv/${VENV}' being created ...${NC}"
    python -m venv ${PROJECT_DIR}/.venv/${VENV}
fi

# activate venv
source /readonly/${PROJECT_DIR}/.venv/${VENV}/bin/activate || return 1
echo -e "${GREEN}Virtual environment '${PROJECT_DIR}/.venv/${VENV}' activated.${NC}"

