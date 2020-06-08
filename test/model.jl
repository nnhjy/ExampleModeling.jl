using Test, JuMP, Cbc

include(joinpath(dirname(@__DIR__), "src", "model.jl"))


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

@test true
