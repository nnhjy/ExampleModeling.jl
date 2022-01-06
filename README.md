# ExampleModeling.jl
[![Docs Image](https://img.shields.io/badge/docs-latest-blue.svg)](https://nnhjy.github.io/ExampleModeling.jl/)
[![Coverage Status](https://coveralls.io/repos/github/nnhjy/ExampleModeling.jl/badge.svg?branch=master)](https://coveralls.io/github/nnhjy/ExampleModeling.jl?branch=master)
<!--- [![Build Status](https://travis-ci.org/gamma-opt/ExampleModeling.jl.svg?branch=master)](https://travis-ci.org/gamma-opt/ExampleModeling.jl) -->

ExampleModeling.jl demonstrates a design pattern for creating structured optimization libraries using JuMP. This template originates from [ExampleModeling.jl](https://github.com/gamma-opt/ExampleModeling.jl) designed by Gamma-Opt group at Aalto University.

## Structure
The source code is structured as follows:
```
src/
├─ ExampleModeling.jl
├─ io.jl
└─ model.jl
```

[`model.jl`](./src/model.jl) contains data structures and methods for the model and its inputs and outputs.

[`io.jl`](./src/io.jl) contains functions for saving and loading structures to JSON files.

[`ExampleModeling.jl`](./src/ExampleModeling.jl) exports the library.

## Design Principles
**Decouple** the model from problem instances. The package defines the abstract model, and the problem instance defines the numerical values for the model parameters.

**Do not use global states**. Aim to write functional-style code. Each function should encapsulate their logic without side effects.

**Do not hardcode solvers**. Users should specify which solver they use. If a function requires a solver, it should take the solver as an argument.

## Development
We can install the package locally for development using the command:
```
pkg> dev .     # install the module/package in current working directory to the activated environment
```
If we want to install the package in a customised environment, do the command below to activate the environment first:
```
pkg> activate ..    # or the directory towards the environment folder
```

## Usage
In the `example` directory there is [run.jl](./examples/run.jl) script, which demonstrates the usage.

To run the `run.jl` script:
```
julia> include("examples\\run.jl")
```

### Solving the Model
We can initialize and solve the model as follows.
```julia
using JuMP, Cbc
using ExampleModeling

# Problem specific values, defined by the user.
m, n, k = 3, 1, 1
a = [-8]
b = [-1]
c = [14, -33, 20]
A = reshape([-1, -4, 2], m, n)
B = reshape([-2, -1, 1], m, k)

# Structures, defined by package.
specs = Specs(relax_integer=false)
indices = Indices(m, n, k)
params = Params(a, b, c, A, B)
model = ExampleModel(specs, indices, params)

# The solver, defined by the user.
set_optimizer(model, Cbc.Optimizer)
optimize!(model)

if termination_status(model) == MOI.INFEASIBLE
    println("Model is infeasible.")
    exit()
end

# Query output values to structures, defined by the package.
variables = Variables(model)
objectives = Objectives(model)
```

### Saving and Loading Results to File
Next, we define an output directory.
```julia
output_dir = "output"
```

We can save the data structures to JSON files as follows.
```julia
save_json(specs, joinpath(output_dir, "specs.json"))
save_json(params, joinpath(output_dir, "params.json"))
save_json(variables, joinpath(output_dir, "variables.json"))
save_json(objectives, joinpath(output_dir, "objectives.json"))
```

We can also load the values from JSON files back to the data structures as follows.
```julia
specs = load_json(Specs, joinpath(output_dir, "specs.json"))
params = load_json(Params, joinpath(output_dir, "params.json"))
variables = load_json(Variables, joinpath(output_dir, "variables.json"))
objectives = load_json(Objectives, joinpath(output_dir, "objectives.json"))
```

### Loading Inputs from File
We can use files to store and distribute problem instances with different input values. For each instance, we need to create a directory with files or directories of files, preferably in plain text formats, such as JSON or CSV. For example:

```
instance/
├─ params/
│  ├─ param1.csv
│  └─ param2.csv
└─ indices.json
```

We can use `load_json` function if the inputs are in the JSON format required by the structures. Otherwise, we need to create custom constructors for the `Indices` and `Params`. The constructors load values from the appropriate files in the instance directory and then perform the necessary computations to convert them into the arguments for the structure. We can define custom constructors as follows.

```julia
using ExampleModeling

function Indices(path::AbstractString, ...)
    # Load the raw values from files in the path.
    # Convert raw values to inputs for structure.
    Indices(...)
end

function Params(path::AbstractString, ...)
    # Load the raw values from files in the path.
    # Convert raw values to inputs for structure.
    Params(...)
end

indices = Indices(joinpath("instance", "indices.json"), ...)
params = Params(joinpath("instance", "params"), ...)
# ...
```

We should hardcode these constructors in the package only if there is an apparent general format for the instance files.

## Tests
We can run tests using the commands:
```
pkg> activate .
ExampleModeling> test
```

## Documentation
We can build the documentation in `docs` directory using the command:
```bash
julia make.jl
```
