using Test, Parameters

include(joinpath(dirname(@__DIR__), "src", "io.jl"))


# --- Test Utility ---

@test flatten([1, 2]) == [1, 2]
@test flatten([[1, 2], [3, 4, 5]]) == [1, 2, 3, 4, 5]

@test shape([1, 2]) == [2]
@test shape([[1, 2, 3], [4, 5, 6]]) == [3, 2]

@test mdim([1, 2]) == [1, 2]
@test mdim([[1, 2, 3], [4, 5, 6]]) == reshape([1, 2, 3, 4, 5, 6], 3, 2)


# --- Test IO ---

@with_kw struct TestStruct
    b::Bool
    i::Int
    f::Float64
    ia1::Array{Int, 1}
    fa1::Array{Float64, 1}
    ia2::Array{Int, 2}
    fa2::Array{Float64, 2}
    iaa::Array{Array{Int, 1}, 1}
    faa::Array{Array{Float64, 1}, 1}
end

test_struct = TestStruct(
    b=true,
    i=1,
    f=1.1,
    ia1=[1, 2, 3],
    fa1=[1.1, 2.2, 3.3],
    ia2=reshape([1, 2, 3, 4, 5, 6], 2, 3),
    fa2=reshape([1.1, 2.2, 3.3, 4.4, 5.5, 6.6], 2, 3),
    iaa=[[0], [1, 2], [3, 4, 5]],
    faa=[[0.0], [1.1, 2.2], [3.3, 4.4, 5.5]]
)

output_dir = tempdir()
filepath = joinpath(output_dir, "test_struct.json")
save_json(test_struct, filepath)
test_struct2 = load_json(TestStruct, filepath)

for field in fieldnames(TestStruct)
    @test getfield(test_struct, field) == getfield(test_struct2, field)
end
