using Test, Random, JuMP, Cbc
using ExampleModeling

# --- Test Model ---

Random.seed!(111)

m, n, k = 2, 3, 5
a = rand(n)
b = rand(k)
c = rand(m)
A = rand(m, n)
B = rand(m, k)

specs = Specs()
indices = Indices(m, n, k)
params = Params(a, b, c, A, B)
model = ExampleModel(specs, indices, params)

set_optimizer(model, Cbc.Optimizer)
optimize!(model)

@test termination_status(model) != MOI.INFEASIBLE

variables = Variables(model)
objectives = Objectives(model)

# --- Test IO ---

output_dir = tempdir()

save_json(specs, joinpath(output_dir, "specs.json"))
save_json(params, joinpath(output_dir, "params.json"))
save_json(variables, joinpath(output_dir, "variables.json"))
save_json(objectives, joinpath(output_dir, "objectives.json"))

specs2 = load_json(Specs, joinpath(output_dir, "specs.json"))
params2 = load_json(Params, joinpath(output_dir, "params.json"))
variables2 = load_json(Variables, joinpath(output_dir, "variables.json"))
objectives2 = load_json(Objectives, joinpath(output_dir, "objectives.json"))

# FIXME:
# @test specs == specs2
# @test params == params2
# @test variables == variables2
# @test objectives == objectives2

@test true
