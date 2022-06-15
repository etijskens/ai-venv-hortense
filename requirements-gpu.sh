#!/bin/bash

# adapted from requirements-gpu.sh
if [[ "${VIRTUAL_ENV}" != "/dodrio/scratch/projects/explor_2022_005/.venv/gpu" ]]
then
    echo "Wrong venv activated: '${VIRTUAL_ENV}', expecting '/dodrio/scratch/projects/explor_2022_005/.venv/gpu'."
    echo "You must run 'source .venv/bin/env-gpu.sh' first."
    exit 1
fi

echo "Starting installation of dependencies ..."
rm -f requirements-cpu.sh.log

python -m pip install --upgrade pip |& tee -a requirements-cpu.sh.log

# modified after EUROSENSE-R-D/pn2-data-parallel-prototype/precompiled_requirements.txt

####################################################################################################
### numpy~=1.19.0
# requirement already satisfied by loaded LMOD module: PyTorch/1.10.0-foss-2021a. (-> numpy v1.20.3)

####################################################################################################
### torch @ https://download.pytorch.org/whl/cu113/torch-1.10.0%2Bcu113-cp38-cp38-linux_x86_64.whl
# requirement already satisfied by loaded LMOD modules: PyTorch/1.10.0-foss-2021a.

####################################################################################################
### torch-scatter~=2.0.9 # @ https://data.pyg.org/whl/torch-1.10.0%2Bcu113/torch_scatter-2.0.9-cp38-cp38-linux_x86_64.whl
# see https://github.com/rusty1s/pytorch_scatter/readme.md 
export FORCE_ONLY_CUDA=1
export TORCH_CUDA_ARCH_LIST="8.0+PTX"
pip install torch-scatter -v --no-deps --no-binary :all: |& tee -a requirements-cpu.sh.log

# installed torch-scatter v2.0.9
# or 
# pip install torch-scatter -f https://data.pyg.org/whl/torch-1.10.0+cu113.html

####################################################################################################
### torch-sparse~=0.6.12 # @ https://data.pyg.org/whl/torch-1.10.0%2Bcu113/torch_sparse-0.6.12-cp38-cp38-linux_x86_64.whl
# see https://github.com/rusty1s/pytorch_sparse/readme.md 
export FORCE_ONLY_CUDA=1
export TORCH_CUDA_ARCH_LIST="8.0+PTX"
pip install torch-sparse -v --no-deps --no-binary :all: |& tee -a requirements-cpu.sh.log
# installed torch-sparse v0.6.13
# or 
# pip install torch-sparse -f https://data.pyg.org/whl/torch-1.10.0+cu113.html


####################################################################################################
### torch-cluster~=1.5.9 # @ https://data.pyg.org/whl/torch-1.10.0%2Bcu113/torch_cluster-1.5.9-cp38-cp38-linux_x86_64.whl
# see https://github.com/rusty1s/pytorch_cluster/readme.md 
export FORCE_ONLY_CUDA=1
export TORCH_CUDA_ARCH_LIST="8.0+PTX"
pip install torch-cluster -v --no-deps --no-binary :all: |& tee -a requirements-cpu.sh.log
# installed torch-cluster v1.6.0
# or 
# pip install torch-cluster -f https://data.pyg.org/whl/torch-1.10.0+cu113.html

####################################################################################################
### torch-points-kernels @ https://github.com/EUROSENSE-R-D/torch-points-kernels/releases/download/v0.7.1/torch_points_kernels-0.7.1-cp38-cp38-linux_x86_64.whl
# see https://github.com/EUROSENSE-R-D/torch-points-kernels/readme.md
# torch-points-kernels v0.7.1 is not on PyPI, we install from al local git clone
FORCE_CUDA=1 pip install ${PROJECT_DIR}/EUROSENSE-R-D/torch-points-kernels -v --no-deps --no-binary :all: |& tee -a requirements-cpu.sh.log
# installed torch-points-kernels v0.7.1
#
# dependencies
# numba, numpy, scikit-learn
pip install numba |& tee -a requirements-cpu.sh.log
# numba is not used for CUDA, hence no precautions to build it with CUDA
# Successfully installed llvmlite-0.38.0 numba-0.55.1
# for numpy see https://github.com/torch-points3d/torch-points-kernels/issues/90
pip install scikit-learn |& tee -a requirements-cpu.sh.log
# Successfully installed joblib-1.1.0 scikit-learn-1.0.2 threadpoolctl-3.1.0


####################################################################################################
### pytorch_metric_learning~=0.9
# see https://github.com/KevinMusgrave/pytorch-metric-learning#installation
pip install pytorch_metric_learning -v --no-deps |& tee -a requirements-cpu.sh.log
# installed pytorch-metric-learning v1.3.0
#
# Dependencies of pytorch_metric_learning
# numpy (pre-installed), scikit-learn (already available 1.0.2), tqdm, torchvision
pip install tqdm |& tee -a requirements-cpu.sh.log
# Successfully installed tqdm-4.64.0
#
# torchvision (use FORCE_CUDA=1 for building with cuda)
FORCE_CUDA=1 pip install torchvision==0.11.1 -v --no-deps |& tee -a requirements-cpu.sh.log
# Successfully installed torchvision-0.11.1 (but binary installed, not built)
# torchvision dependencies: typing_extensions (already available: 3.10.0.0), numpy (pre-installed), requests, Jinja2
pip install requests |& tee -a requirements-cpu.sh.log
# Successfully installed charset-normalizer-2.0.12 idna-3.3 requests-2.27.1
pip insstall Jinja2 |& tee -a requirements-cpu.sh.log
# Successfully installed Jinja2-3.1.2 MarkupSafe-2.1.1

####################################################################################################
### scikit-image~=0.16
pip install scikit-image |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   PyWavelets-1.3.0 
#   imageio-2.19.1 
#   networkx-2.8 
#   packaging-21.3
#   pillow-9.1.0  
#   pyparsing-3.0.9 
#   scikit-image-0.19.2 
#   tifffile-2022.5.4

####################################################################################################
### plyfile~=0.7.2
pip install plyfile |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   plyfile-0.7.4

####################################################################################################
### gdown~=3.12.0
pip install gdown |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   PySocks-1.7.1 
#   beautifulsoup4-4.11.1 
#   filelock-3.6.0 
#   gdown-4.4.0 
#   six-1.16.0 
#   soupsieve-2.3.2.post1

####################################################################################################
### progress~=1.6
pip install progress |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   progress-1.6

####################################################################################################
### laspy~=2.1.2
pip install laspy |& tee -a requirements-cpu.sh.log
# laspy~=1.7.1 fails miserably
# Successfully installed \
#   laspy-2.1.2

####################################################################################################
### h5py~=3.1.0
# available from LMOD module h5py/3.2.1-foss-2021a

####################################################################################################
### torch-geometric~=2.0.2
pip install torch-geometric -v --no-deps |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   torch-geometric-2.0.4

####################################################################################################
### hydra-core~=0.11.3
pip install hydra-core~=0.11.3 |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   antlr4-python3-runtime-4.8 
#   hydra-core-1.1.2 
#   omegaconf-2.1.2

####################################################################################################
### wandb~=0.12.9
pip install wandb |& tee -a requirements-cpu.sh.log

# matplotlib~=3.4.3
# we do with LMOD module matplotlib/3.4.2-foss-2021a 

# tqdm~=4.62.3
# requirement already satisfied

# open3d ~=0.12.0
# we'll pass on this one, not for an HPC environment

####################################################################################################
### torchnet==0.0.4
pip install torchnet |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   jsonpatch-1.32 
#   jsonpointer-2.3 
#   pyzmq-22.3.0 
#   torchfile-0.1.0 
#   torchnet-0.0.4 
#   tornado-6.1 
#   visdom-0.1.8.9 
#   websocket-client-1.3.2

####################################################################################################
### tensorboard~=2.1.0
pip install tensorboard |& tee -a requirements-cpu.sh.log
# Successfully installed 
#   absl-py-1.0.0 
#   cachetools-5.0.0 
#   google-auth-2.6.6 
#   google-auth-oauthlib-0.4.6 
#   grpcio-1.46.0 
#   importlib-metadata-4.11.3 
#   markdown-3.3.7 
#   oauthlib-3.2.0 
#   pyasn1-0.4.8 
#   pyasn1-modules-0.2.8 
#   requests-oauthlib-1.3.1 
#   rsa-4.8 
#   tensorboard-2.9.0 
#   tensorboard-data-server-0.6.1 
#   tensorboard-plugin-wit-1.8.1 
#   werkzeug-2.1.2 
#   wheel-0.37.1 
#   zipp-3.8.

### missing
pip install toml
pip install Jinja2
pip install pytz
# Successfully installed pytz-2022.1
pip install pycuda
# Successfully installed appdirs-1.4.4 mako-1.2.0 platformdirs-2.5.2 pycuda-2021.1 pytools-2022.1.7 typing_extensions-4.2.0

# still a few missing dependencies
pip install cupy
pip install geopandas
pip install laszip

# just running `pip install colossalai` fails to install the colossalai cli tool.
pusd ${PROJECT_DIR}/Colossalai
pip install colossalai
popd

pip install class-resolver