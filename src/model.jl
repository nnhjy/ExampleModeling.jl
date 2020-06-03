using Parameters, JuMP

"""Defines the ExampleModel type."""
const ExampleModel = Model

"""Specifies which parts of the model to run."""
@with_kw struct Specs
    spec::Bool=true
end

"""Model indices."""
@with_kw struct Indices
    m::Integer
    n::Integer
    k::Integer
end

"""Model parameter values."""
@with_kw struct Params
    a::Array{AbstractFloat, 1}
    b::Array{AbstractFloat, 1}
    c::Array{AbstractFloat, 1}
    A::Array{AbstractFloat, 2}
    B::Array{AbstractFloat, 2}
end

"""Model variable values."""
@with_kw struct Variables
    x::Array{AbstractFloat, 1}
    y::Array{Integer, 1}
end

"""Model objective values."""
@with_kw struct Objectives
    f::AbstractFloat
end

"""Initializes the ExampleModel."""
function ExampleModel(specs::Specs, indices::Indices, params::Params)
    model = ExampleModel()

    @unpack m, n, k = indices
    @unpack a, b, c, A, B = params

    # Variables
    @variable(model, x[1:n]≥0)
    @variable(model, y[1:k]≥0, Int)

    # Objectives
    @expression(model, f, 
        sum(a[i]*x[i] for i in 1:n) + 
        sum(b[i]*y[i] for i in 1:k)
    )
    @objective(model, Max, f)

    # Constraints
    @constraint(model, [i = 1:m],
        sum(A[i, j]*x[j] for j in 1:n) + 
        sum(B[i, j]*y[j] for j in 1:k) ≤ c[i])

    return model
end

data(a::Number) = a
data(a::Array{<:Number, T}) where T = a
data(a::JuMP.Containers.DenseAxisArray) = a.data
round_int(x::AbstractFloat) = Integer(round(x))
convert_int(x, t::Type{<:Integer}) = round_int(x)
convert_int(x, t::Type{Array{T, N}}) where T <: Integer where N = round_int.(x)
convert_int(x, t) = x

"""Values from model to dtype.

# Arguments
- `dtype` (DataType)
- `model::Model`
"""
function model_to_dtype(dtype, model::Model)
    fields = []
    for (n, t) in zip(fieldnames(dtype), fieldtypes(dtype))
        push!(fields, value.(model[n]) |> data |> x -> convert_int(x, t))
    end
    dtype(fields...)
end

"""Query variable values from the model into Variables type."""
Variables(model::ExampleModel) = model_to_dtype(Variables, model)

"""Query objective values from the model into Objectives type."""
Objectives(model::ExampleModel) = model_to_dtype(Objectives, model)
