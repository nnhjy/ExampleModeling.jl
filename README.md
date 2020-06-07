# ExampleModeling.jl
This package demonstrates how to build a JuMP model with data structures and save and load these structures to JSON files. We can use it as a design pattern for creating optimization libraries using JuMP.

## Design Principles
**Decouple** the model from problem instances. The package defines the abstract model, and the problem instance defines the numerical values for the model parameters.

**Do not use global states**. Aim to write functional-style code. Each function should encapsulate their logic without side effects.

**Do not hardcode solvers**. Users should specify which solver they use. If a function requires a solver, it should take the solver as an argument.

## Development
We can install the package locally for development using the command:
```
pkg> dev .
```

## Usage
In the `example` directory there is [run.jl](examples/runl.jl) example script. 

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
specs = Specs()
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
We can build the documentation using the command:
```bash
julia make.jl
```
