# ExampleModeling.jl
Documentation for ExampleModeling.jl

## Formulation
The canonical mixed integer linear program is formulated:

$$\begin{aligned}
\text{maximize }& 𝐚𝐱 + 𝐛𝐲 \\
\text{subject to }
& 𝐀 𝐱 + 𝐁 𝐲 ≤ 𝐜 \\
& 𝐱,𝐲 ≥ 0 \\
& 𝐲 ∈ ℤ
\end{aligned}$$

Indices: $m,n,k∈ℤ$

Parameters: 

*  $𝐚∈ℝ^{n}$
*  $𝐛∈ℝ^{k}$
*  $𝐜∈ℝ^{m}$
*  $𝐀∈ℝ^{m×n}$
*  $𝐁∈ℝ^{m×k}$

Variables: 

*  $𝐱∈ℝ^{n}$
*  $𝐲∈ℤ^{k}$

Objective: 

*  $f(𝐱,𝐲)= 𝐚𝐱 + 𝐛𝐲$
