module ExampleModeling

include("model.jl")
export ExampleModel,
    Specs,
    Indices,
    Params,
    Variables,
    Objectives,
    model_to_dtype

include("io.jl")
export save_json, 
    load_json

end # module
