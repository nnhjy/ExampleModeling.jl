module ExampleModeling

include("model.jl")
include("io.jl")
export ExampleModel,
    Specs,
    Params,
    Variables,
    Objectives,
    save_json,
    load_json

end # module
