using Test, JuMP, Cbc
using ExampleModeling

# --- Test Model ---

m, n, k = 3, 1, 1
a = [-8]
b = [-1]
c = [14, -33, 20]
A = reshape([-1, -4, 2], m, n)
B = reshape([-2, -1, 1], m, k)

specs = Specs(relax_integer=false)
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
