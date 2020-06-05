# ExampleModeling.jl
Documentation for ExampleModeling.jl

## Formulation
We formulate the canonical *mixed-integer linear program* as follows:

$$\begin{aligned}
\text{maximize }& 𝐚𝐱 + 𝐛𝐲 \\
\text{subject to }
& 𝐀 𝐱 + 𝐁 𝐲 ≤ 𝐜 \\
& 𝐱,𝐲 ≥ 0 \\
& 𝐲 ∈ ℤ.
\end{aligned}$$

We refer to the formulation as **model**. The model takes as inputs the indices and parameters.

**Indices**:

*  $m,n,k∈ℤ$

**Parameters**:

*  $𝐚∈ℝ^{n}$
*  $𝐛∈ℝ^{k}$
*  $𝐜∈ℝ^{m}$
*  $𝐀∈ℝ^{m×n}$
*  $𝐁∈ℝ^{m×k}$

The model outputs the variables and objectives.

**Variables**:

*  $𝐱∈ℝ^{n}$
*  $𝐲∈ℤ^{k}$

**Objectives**:

*  $f(𝐱,𝐲)= 𝐚𝐱 + 𝐛𝐲$

You can read more about the theory of integer programming from [^1].


## References
[^1]: Wolsey, L. A. (1998). Integer programming. Wiley.
