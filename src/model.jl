using Parameters, JuMP

"""Defines the ExampleModel type."""
const ExampleModel = Model

"""Specifies which parts of the model to run."""
@with_kw struct Specs
end

"""Model parameter values."""
@with_kw struct Params
end

"""Model variable values."""
@with_kw struct Variables
end

"""Model objective values."""
@with_kw struct Objectives
end

"""Initializes the ExampleModel."""
function ExampleModel(specs::Specs, params::Params)
    model = ExampleModel()

    # TODO: extract parameters

    # TODO: variables

    # TODO: objectives

    # TODO: variables

    return model
end

data(a::Number) = a
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
