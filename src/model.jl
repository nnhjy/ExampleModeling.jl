using Parameters, JuMP
using JuMP.Containers: DenseAxisArray


# --- Utility ---

data(a::DenseAxisArray) = a.data
data(a::Any) = a

round_int(x::AbstractFloat) = Integer(round(x))
convert_int(x, ::Type{<:Integer}) = round_int(x)
convert_int(x, ::Type{Array{T, N}}) where T <: Integer where N = round_int.(x)
convert_int(x, ::Any) = x

"""The function queries values from the model to data type based on its field names. It extracts values from DenseAxisArray from its `data` field. Then, it converts the values to the corresponding field type. The function rounds integers before conversion because JuMP outputs integer variables as floats."""
function model_to_dtype(dtype::DataType, model::Model)
    fields = (
        value.(model[n]) |> data |> x -> convert_int(x, t)
        for (n, t) in zip(fieldnames(dtype), fieldtypes(dtype)))
    dtype(fields...)
end


# --- Model ---

"""Defines the ExampleModel type."""
const ExampleModel = Model

"""Specification for different model scenarios. For example, we can specify toggling on and off certain constraints and objectives.

# Arguments
- `relax_integer::Bool=false`: If true, relax integer constraints from variables. 
"""
@with_kw struct Specs
    relax_integer::Bool=false
end

"""Contains indices of the model."""
@with_kw struct Indices
    m::Integer
    n::Integer
    k::Integer
end

"""Contains the parameters of the model."""
@with_kw struct Params
    a::Array{AbstractFloat, 1}
    b::Array{AbstractFloat, 1}
    c::Array{AbstractFloat, 1}
    A::Array{AbstractFloat, 2}
    B::Array{AbstractFloat, 2}
end

"""Contains the variable values of the model."""
@with_kw struct Variables
    x::Array{AbstractFloat, 1}
    y::Array{Integer, 1}
end

"""Contains the objective values of the model."""
@with_kw struct Objectives
    f::AbstractFloat
end

"""Queries the variable values from the model into Variables type."""
Variables(model::ExampleModel) = model_to_dtype(Variables, model)

"""Queries the objective values from the model into Objectives type."""
Objectives(model::ExampleModel) = model_to_dtype(Objectives, model)

"""Initializes the ExampleModel."""
function ExampleModel(specs::Specs, indices::Indices, params::Params)
    @unpack m, n, k = indices
    @unpack a, b, c, A, B = params

    # Initialize the model
    model = ExampleModel()

    # Variables
    @variable(model, x[1:n]≥0)
    @variable(model, y[1:k]≥0, Int)
    if specs.relax_integer
        unset_integer.(y)
    end

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
