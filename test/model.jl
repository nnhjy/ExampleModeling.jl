using Test, JuMP, Cbc
using JuMP.Containers: DenseAxisArray

include(joinpath(dirname(@__DIR__), "src", "model.jl"))


# --- Test Utility ---

@test data(DenseAxisArray([1, 2], [:a, :b])) == [1, 2]
@test data([1, 2]) == [1, 2]

@test round_int(1.1) == 1
@test convert_int(1.001, Int) == 1
@test convert_int([1.001, 2.003], Array{Int, 1}) == [1, 2]
@test convert_int(1.001, Float64) == 1.001


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
