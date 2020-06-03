using JuMP, Gurobi

push!(LOAD_PATH, dirname(@__DIR__))
using ExampleModeling

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

optimizer = with_optimizer(
    Gurobi.Optimizer,
    TimeLimit=60,
)
optimize!(model, optimizer)

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
