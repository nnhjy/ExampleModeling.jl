using JSON

"""Saves the given DataType into JSON file.

# Arguments
- `dtype`
- `output_path::AbstractString`: Full filepath, e.g., `path.json`.
"""
function save_json(dtype, filepath::AbstractString)
    open(filepath, "w") do io
        JSON.print(io, dtype)
    end
end

flatten(x::Array{<:Array, 1}) = Iterators.flatten(x)|> collect|> flatten
flatten(x::Array{<:Number, 1}) = x

shape(x::Array{<:Array, 1}) = vcat(shape(first(x)), [length(x)])
shape(x::Array{<:Number, 1}) = [length(x)]

mdim(x::Array{<:Array, 1}) = reshape(flatten(x), shape(x)...)
mdim(x::Array{<:Number, 1}) = x

transform(x::Array, t::Type{Array{T, N}}) where T <: Number where N = mdim(x)
transform(x::Array, t::Type{Array{T, 1}}) where T <: Array = x
transform(x::Number, t::Type{T}) where T <: Number = x

function convert_type(::Type{Array{T, N}}) where T <: Number where N
    t = T
    for i in 1:N
        t = Array{t, 1}
    end
    return t
end
convert_type(::Type{Array{T, 1}}) where T <: Array = Array{T, 1}
convert_type(t::Type{T}) where T <: Number = t

"""Loads values from JSON file to given DataType.

# Arguments
- `dtype`: DataType
- `filepath::AbstractString`
"""
function load_json(dtype, filepath::AbstractString)
    objects = JSON.parsefile(filepath)
    fields = []
    for (s, t) in zip(fieldnames(dtype), fieldtypes(dtype))
        push!(fields,
              objects[string(s)] |>
              v -> convert(convert_type(t), v) |>
              v -> transform(v, t))
    end
    dtype(fields...)
end
