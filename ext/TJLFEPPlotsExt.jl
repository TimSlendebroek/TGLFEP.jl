module TJLFEPPlotsExt

# Critical-gradient plots; loaded with `using Plots`, so FUSE worker processes never load Plots through TJLFEP
using Plots
using Printf
import TJLFEP
# mirror the TJLFEP namespace (what the included code saw inside `module TJLFEP`): its own and imported names first,
# then the modules it brings in with `using` (names(...; usings=true) would need Julia 1.12)
for n in names(TJLFEP; all=true, imported=true)
    if Base.isidentifier(n) && n ∉ (:TJLFEP, :eval, :include) && isdefined(TJLFEP, n) && !isdefined(@__MODULE__, n)
        @eval import TJLFEP: $n
    end
end
using Base.Threads, LinearAlgebra, Printf, SparseArrays, StaticArrays, TJLF

include(joinpath("..", "src", "plotCritGrads_plots.jl"))

end
