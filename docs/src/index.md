# ExampleModeling.jl
Documentation for ExampleModeling.jl

## Formulation
We formulate the canonical *mixed-integer linear program* as follows:

$$\begin{aligned}
\text{maximize }& ğğ± + ğğ² \\
\text{subject to }
& ğ ğ± + ğ ğ² â¤ ğ \\
& ğ±,ğ² â¥ 0 \\
& ğ² â â¤.
\end{aligned}$$

We refer to the formulation as **model**. The model takes as inputs the indices and parameters.

**Indices**:

*  $m,n,kââ¤$

**Parameters**:

*  $ğââ^{n}$
*  $ğââ^{k}$
*  $ğââ^{m}$
*  $ğââ^{mÃn}$
*  $ğââ^{mÃk}$

The model outputs the variables and objectives.

**Variables**:

*  $ğ±ââ^{n}$
*  $ğ²ââ¤^{k}$

**Objectives**:

*  $f(ğ±,ğ²)= ğğ± + ğğ²$

You can read more about the theory of integer programming from [^1].


## References
[^1]: Wolsey, L. A. (1998). Integer programming. Wiley.
