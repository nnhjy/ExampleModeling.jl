# ExampleModeling.jl
This package demonstrates how to build a JuMP model with data structures and save and load these structures to JSON files. We can use it as a design pattern for creating optimization libraries using JuMP.

## Development
We can install the package locally for development using the command:
```
pkg> dev .
```

## Usage
In the `example` directory there is [run.jl](examples/runl.jl) example script. 

We can initialize and solve the model as follows.
```julia
using JuMP, Cbc
using ExampleModeling

m, n, k = 3, 1, 1
a = [-8]
b = [-1]
c = [14, -33, 20]
A = reshape([-1, -4, 2], m, n)
B = reshape([-2, -1, 1], m, k)

specs = Specs()
indices = Indices(m, n, k)
params = Params(a, b, c, A, B)
model = ExampleModel(specs, indices, params)

set_optimizer(model, Cbc.Optimizer)
optimize!(model)

if termination_status(model) == MOI.INFEASIBLE
    println("Model is infeasible.")
    exit()
end

variables = Variables(model)
objectives = Objectives(model)
```

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
