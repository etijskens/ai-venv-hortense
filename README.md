# colossalai-venv-hortense

two pairs of scripts for 
* creating (if non-exisisting) and activating a virtual python environment with pyTorch and Colossalai: `env-<x>pu.sh`, where `x = g|c`, referring to resp. a gpu and a cpu environment.
* installing the nessary components in that environment: `requirements-<x>pu.sh`. note that prior to the installation one should execute: 

        > dodrio-bind-readonly /bin/bash
        > source .venv/bin/env-gpu.sh
        (gpu) >

  (for the cpu environment `env-cpu.sh` should be `source`d, obviously.)