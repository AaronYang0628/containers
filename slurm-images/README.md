### Build Image
```shell
MPI_TYPE=open-mpi #intel-mpi
bash ./builder/build.sh
bash ./base/build.sh
bash ./munged/build.sh
bash ./login/build.sh
bash ./slurmctld/build.sh
bash ./slurmd/build.sh
bash ./slurmdbd/build.sh
```

### Push Image to docker.io
```shell
docker tag <IMAGE_ID> aaron666/slurm-xxxx
docker push aaron666/slurm-xxxx
```

### Example Job Script
```c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    int rank, size;

    // Initialize the MPI environment
    MPI_Init(&argc, &argv);

    // Get the rank and size
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Print out a message from each process
    printf("Hello from rank %d of %d\n", rank, size);

    // Finalize the MPI environment
    MPI_Finalize();

    return 0;
}

```

```bash
#!/bin/bash
#SBATCH --job-name=mpi_job       # Job name
#SBATCH --nodes=2                # Number of nodes to use
#SBATCH --ntasks-per-node=1      # Number of tasks per node
#SBATCH --time=00:10:00          # Time limit
#SBATCH --output=mpi_job.out     # Standard output file
#SBATCH --error=mpi_job.err      # Standard error file

# Manually set Intel OneAPI MPI and Compiler environment
export I_MPI_PMI=pmi2
export I_MPI_PMI_LIBRARY=/usr/lib/x86_64-linux-gnu/slurm/mpi_pmi2.so
export I_MPI_ROOT=/opt/intel/oneapi/mpi/2021.14
export INTEL_COMPILER_ROOT=/opt/intel/oneapi/compiler/2025.0
export PATH=$I_MPI_ROOT/bin:$INTEL_COMPILER_ROOT/bin:$PATH
export LD_LIBRARY_PATH=$I_MPI_ROOT/lib:$INTEL_COMPILER_ROOT/lib:$LD_LIBRARY_PATH
export MANPATH=$I_MPI_ROOT/man:$INTEL_COMPILER_ROOT/man:$MANPATH

# Compile the MPI program
icx-cc -I$I_MPI_ROOT/include  simple_mpi.c -o simple_mpi -L$I_MPI_ROOT/lib -lmpi

# Run the MPI job

mpirun -np 2 ./simple_mpi
```