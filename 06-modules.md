# Modules

Tillicum uses the [Lmod](https://lmod.readthedocs.io/en/latest/) environment module system to manage software. Each loaded module dynamically updates your environment variables (e.g. `PATH`, `LD_LIBRARY_PATH`) so that the corresponding executables and libraries become available.

## Understanding Your Environment

When you log in, your shell environment combines: 

- System defaults — environment variables and functions defined globally for all users.
- User customizations - variables or aliases defined in your startup files (e.g., $HOME/.bashrc, $HOME/.bash_profile).
- Modules - software environment modifications from any loaded modules.

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. `PATH` is a colon-separated list of directory paths that the system searches for your executables. `LD_LIBRARY_PATH` is a similar list where the system looks for shared libraries.

Example:
```bash
$ echo $PATH
/gpfs/home/kcxie/.local/bin:/gpfs/home/kcxie/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/dell/srvadmin/bin
```

## Lmod

Lmod is a Lua-based module system that provides a convenient way to dynamically change your environment (`PATH`, `LD_LIBRARY_PATH`, etc.) through modulefiles to use different software stacks. Lmod is an implementation of environment modules that easily handles the hierarchical `MODULEPATH`.

## Command Summary

The module command sets the appropriate environment variable independent of your shell.

| Command | Description|
|:-----|:-----|
| `module list` | List active modules in the current session |
| `module avail` | List available modules in `MODULEPATH` |
| `module spider [module]`| Search all modules in `MODULEPATH` and every module hierarchy |
| `module load [modules]` | Load modules |
| `module swap [module1] [module2]` | Replace `module1` with `module2` |
| `module unload [modules]` | Unload specific modules |
| `module purge` | Unload ALL modules from the current session |
| `module show [module]` | Show functions performed by loading module |
| `module help [module]` | Show module-specific help message |
| `module use [-a] [path]` | Prepend or append path to `MODULEPATH` |

Lmod provides a convenient shortcut command [`ml`](https://lmod.readthedocs.io/en/latest/010_user.html#ml-a-convenient-tool) for the `module` command.

> 💡 **TIP:** `ml` can be used instead of module, module load, or module list depending on the situation. This can be seen in the examples below.

| Example | Equivalent|
|:-----|:-----|
| `ml` | `module list` |
| `ml [module]` | `module load [module]` |
| `ml -[module]` | `module unload [module]` |
| `ml avail` | `module avail` |

Any module sub-commands (e.g., avail, spider, show, etc.) can be written as `ml subcommand arg1 arg2`.

## Finding Modules

### Using `module avail`

List all modules visible in your current session:

```bash
$ module avail

--------------------------------- /gpfs/software/modulefiles/Core ---------------------------------
   conda/Miniforge3-25.3.1-3    gcc/13.4.0      (D)    parallel/20240822
   gcc/11.5.0                   jupyter/minimal

  Where:
   D:  Default Module
   . . .
```

The output of this will be quite long depending on the number of modulefiles. To narrow results, for instance, if you want to see all `gcc` modules:

```bash
$ module avail gcc

--------------------------------- /gpfs/software/modulefiles/Core ---------------------------------
   gcc/11.5.0    gcc/13.4.0 (D)
   . . .
```

### Using `module spider`

The `module spider` command performs a **deep search** through all module hierarchies, even ones not currently visible. Note that module avail doesn't show modules from all trees in the hierarchical system. If you want to know all available software on the system, please use `module spider`.

```bash
$ module spider cuda

------------------------------------------------------------------------------------------------
  cuda:
------------------------------------------------------------------------------------------------
    Description:
      NVIDIA CUDA Toolkit for GPU-accelerated computing.

     Versions:
        cuda/12.4.0
        cuda/12.9.1
        cuda/13.0.0

------------------------------------------------------------------------------------------------
  For detailed information about a specific "cuda" package (including how to load the modules) use t
he module's full name.
  Note that names that have a trailing (E) are extensions provided by other modules.
  For example:

     $ module spider cuda/13.0.0
------------------------------------------------------------------------------------------------
```

```bash
$ module spider cuda/13.0.0

------------------------------------------------------------------------------------------------
  cuda: cuda/13.0.0
------------------------------------------------------------------------------------------------
    Description:
      NVIDIA CUDA Toolkit for GPU-accelerated computing.


    You will need to load all module(s) on any one of the lines below before the "cuda/13.0.0" modul
e is available to load.

      gcc/13.4.0
 
    Help:
      Adds CUDA Toolkit 13.0.0 to your environment.
      
      The NVIDIA CUDA Toolkit provides a development environment for creating high-performance, GPU-
accelerated applications. The toolkit includes GPU-accelerated libraries, debugging and optimization
 tools, a C/C++ compiler, and a runtime library.
```

The above output also indicates a modulefile's complete name includes its name and version. An installed application can have several versions. `module spider cuda/13.0.0` also illustrates that `gcc/13.4.0` needs to be loaded at first before `cuda/13.0.0` is available to load.

> 📝 **NOTE:** `module spider` is the most reliable way to see all installed software and learn what prerequisites must be loaded first. **Always use `module spider` instead of `module avail` to find out how to `module load`.**

## Module Hierarchies

Tillicum uses a hierarchical module structure to ensure compatibility between software stacks.

**Hierarchy Levels**

In Lmod module hierarchy, each compiler module adds to the `MODULEPATH` a compiler version modulefile directory. Only modulefiles that exist in that directory are packages that have been built with that compiler. Similarly, applications that use libraries depending on MPI implementations must be built with the same compiler - MPI pairing. This leads to modulefile hierarchy.

**Steps to Load Modules**

- First, load a compiler (e.g., GCC).
- Then, only the modules built with that compiler will be visible with `module avail`.
- This reduces incompatibilities and helps ensure a smoother user experience.

**Example**

With a clean environment `module avail` lists only the available core modules which include compilers.

```bash
$ module avail

--------------------------------- /gpfs/software/modulefiles/Core ---------------------------------
   conda/Miniforge3-25.3.1-3    gcc/13.4.0      (D)    parallel/20240822
   gcc/11.5.0                   jupyter/minimal
```

Once you load a particular compiler, you will only see the modules that depend on that compiler with `module avail`.

```bash
$ module load gcc/13.4.0
$ module avail

------------------------------ /gpfs/software/modulefiles/gcc/13.4.0 ------------------------------
   cmake/3.31.8    cuda/12.9.1 (D)    cuda/13.0.0    ffmpeg/7.1

--------------------------------- /gpfs/software/modulefiles/Core ---------------------------------
   conda/Miniforge3-25.3.1-3    gcc/13.4.0      (L,D)    parallel/20240822
   gcc/11.5.0                   jupyter/minimal
```

Now CUDA modules built with GCC 13.4.0 become visible.

```bash
$ module load cuda/13.0.0
$ module list

Currently Loaded Modules:
  1) gcc/13.4.0   2) cuda/13.0.0
```

Then load CUDA and MPI:

```bash
$ module load gcc
$ module load cuda
$ module load openmpi/5.0.8
$ module list

Currently Loaded Modules:
  1) gcc/13.4.0   2) cuda/12.9.1   3) openmpi/5.0.8
```

If you swap compilers, Lmod automatically unloads any modules that depends on the old compiler and reloads those modules that are dependent on the new compiler.

```bash
$ module load gcc/11.5.0 

Inactive Modules:
  1) openmpi/5.0.8

The following have been reloaded with a version change:
  1) cuda/12.9.1 => cuda/12.4.0     2) gcc/13.4.0 => gcc/11.5.0
```

> ⚠️ **WARNING:** Do not include `module load` commands in your startup files (e.g., $HOME/.bashrc and $HOME/.bash_profile). This can cause conflicts when switching environments in batch jobs or interactively.

## User Collections (Optinonal)

You can save and restore commonly used modules using [user collections](https://lmod.readthedocs.io/en/latest/010_user.html#user-collections). Note that Lmod can load only one user collection at a time.