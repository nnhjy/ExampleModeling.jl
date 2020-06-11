using JSON


# --- Utility ---

flatten(x::Array{<:Array, 1}) = Iterators.flatten(x)|> collect|> flatten
flatten(x::Array{<:Number, 1}) = x

shape(x::Array{<:Array, 1}) = vcat(shape(first(x)), [length(x)])
shape(x::Array{<:Number, 1}) = [length(x)]

mdim(x::Array{<:Array, 1}) = reshape(flatten(x), shape(x)...)
mdim(x::Array{<:Number, 1}) = x

transform(x::Array, ::Type{Array{T, N}}) where T <: Number where N = mdim(x)
transform(x::Array, ::Type{Array{T, 1}}) where T <: Array = x
transform(x::Number, ::Type{T}) where T <: Number = x

function convert_type(::Type{Array{T, N}}) where T <: Number where N
    reduce((t,_) -> Array{t, 1}, 1:N; init=T)
end
convert_type(t::Type{Array{T, 1}}) where T <: Array = t
convert_type(t::Type{T}) where T <: Number = t


# -- IO ---

"""Saves any JSON serializable `object` into JSON file in `filepath`."""
function save_json(object::Any, filepath::AbstractString)
    open(filepath, "w") do io
        JSON.print(io, object)
    end
end

"""Loads values from JSON file in `filepath` to DataType supplied by `dtype`."""
function load_json(dtype::DataType, filepath::AbstractString)
    objects = JSON.parsefile(filepath)
    fields = (
        objects[string(s)] |>
        v -> convert(convert_type(t), v) |>
        v -> transform(v, t)
        for (s, t) in zip(fieldnames(dtype), fieldtypes(dtype)))
    dtype(fields...)
end
