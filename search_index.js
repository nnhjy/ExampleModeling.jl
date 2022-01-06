var documenterSearchIndex = {"docs":
[{"location":"api/#API","page":"API","title":"API","text":"","category":"section"},{"location":"api/#Model","page":"API","title":"Model","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"ExampleModel\r\nSpecs\r\nIndices\r\nParams\r\nVariables\r\nObjectives\r\nExampleModel(::Specs, ::Indices, ::Params)\r\nVariables(::ExampleModel)\r\nObjectives(::ExampleModel)","category":"page"},{"location":"api/#ExampleModeling.ExampleModel","page":"API","title":"ExampleModeling.ExampleModel","text":"Defines the ExampleModel type.\n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.Specs","page":"API","title":"ExampleModeling.Specs","text":"Specification for different model scenarios. For example, we can specify toggling on and off certain constraints and objectives.\n\nArguments\n\nrelax_integer::Bool=false: If true, relax integer constraints from variables. \n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.Indices","page":"API","title":"ExampleModeling.Indices","text":"Contains indices of the model.\n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.Params","page":"API","title":"ExampleModeling.Params","text":"Contains the parameters of the model.\n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.Variables","page":"API","title":"ExampleModeling.Variables","text":"Contains the variable values of the model.\n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.Objectives","page":"API","title":"ExampleModeling.Objectives","text":"Contains the objective values of the model.\n\n\n\n\n\n","category":"type"},{"location":"api/#ExampleModeling.ExampleModel-Tuple{Specs, Indices, Params}","page":"API","title":"ExampleModeling.ExampleModel","text":"Initializes the ExampleModel.\n\n\n\n\n\n","category":"method"},{"location":"api/#ExampleModeling.Variables-Tuple{JuMP.Model}","page":"API","title":"ExampleModeling.Variables","text":"Queries the variable values from the model into Variables type.\n\n\n\n\n\n","category":"method"},{"location":"api/#ExampleModeling.Objectives-Tuple{JuMP.Model}","page":"API","title":"ExampleModeling.Objectives","text":"Queries the objective values from the model into Objectives type.\n\n\n\n\n\n","category":"method"},{"location":"api/#IO","page":"API","title":"IO","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"save_json\r\nload_json","category":"page"},{"location":"api/#ExampleModeling.save_json","page":"API","title":"ExampleModeling.save_json","text":"Saves any JSON serializable object into JSON file in filepath.\n\n\n\n\n\n","category":"function"},{"location":"api/#ExampleModeling.load_json","page":"API","title":"ExampleModeling.load_json","text":"Loads values from JSON file in filepath to DataType supplied by dtype.\n\n\n\n\n\n","category":"function"},{"location":"api/#Utility","page":"API","title":"Utility","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"model_to_dtype","category":"page"},{"location":"api/#ExampleModeling.model_to_dtype","page":"API","title":"ExampleModeling.model_to_dtype","text":"The function queries values from the model to data type based on its field names. It extracts values from DenseAxisArray from its data field. Then, it converts the values to the corresponding field type. The function rounds integers before conversion because JuMP outputs integer variables as floats.\n\n\n\n\n\n","category":"function"},{"location":"#ExampleModeling.jl","page":"Home","title":"ExampleModeling.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for ExampleModeling.jl","category":"page"},{"location":"#Formulation","page":"Home","title":"Formulation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"We formulate the canonical mixed-integer linear program as follows:","category":"page"},{"location":"","page":"Home","title":"Home","text":"beginaligned\r\ntextmaximize  𝐚𝐱 + 𝐛𝐲 \r\ntextsubject to \r\n 𝐀 𝐱 + 𝐁 𝐲  𝐜 \r\n 𝐱𝐲  0 \r\n 𝐲  ℤ\r\nendaligned","category":"page"},{"location":"","page":"Home","title":"Home","text":"We refer to the formulation as model. The model takes as inputs the indices and parameters.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Indices:","category":"page"},{"location":"","page":"Home","title":"Home","text":"mnkℤ","category":"page"},{"location":"","page":"Home","title":"Home","text":"Parameters:","category":"page"},{"location":"","page":"Home","title":"Home","text":"𝐚ℝ^n\n𝐛ℝ^k\n𝐜ℝ^m\n𝐀ℝ^mn\n𝐁ℝ^mk","category":"page"},{"location":"","page":"Home","title":"Home","text":"The model outputs the variables and objectives.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Variables:","category":"page"},{"location":"","page":"Home","title":"Home","text":"𝐱ℝ^n\n𝐲ℤ^k","category":"page"},{"location":"","page":"Home","title":"Home","text":"Objectives:","category":"page"},{"location":"","page":"Home","title":"Home","text":"f(𝐱𝐲)= 𝐚𝐱 + 𝐛𝐲","category":"page"},{"location":"","page":"Home","title":"Home","text":"You can read more about the theory of integer programming from [1].","category":"page"},{"location":"#References","page":"Home","title":"References","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"[1]: Wolsey, L. A. (1998). Integer programming. Wiley.","category":"page"}]
}
