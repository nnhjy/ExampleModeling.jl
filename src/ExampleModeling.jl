module ExampleModeling

include("model.jl")
include("io.jl")
export ExampleModel,
    Specs,
    Indices,
    Params,
    Variables,
    Objectives,
    save_json,
    load_json,
    model_to_dtype

end # module
