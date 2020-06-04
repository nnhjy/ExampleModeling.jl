using JuMP, Cbc, Random

push!(LOAD_PATH, dirname(@__DIR__))
using ExampleModeling

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

if termination_status(model) == MOI.INFEASIBLE
    println("Model is infeasible.")
    exit()
end

variables = Variables(model)
objectives = Objectives(model)

print(indices)
print(params)
println(variables)
println(objectives)
