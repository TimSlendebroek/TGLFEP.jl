module TJLFEPPlotsExt

# Critical-gradient plots; loaded with `using Plots`, so FUSE worker processes never load Plots through TJLFEP
using Plots
using Printf
import TJLFEP
for n in names(TJLFEP; all=true, imported=true, usings=true)   # everything visible inside `module TJLFEP`
    if Base.isidentifier(n) && n ∉ (:TJLFEP, :eval, :include) && isdefined(TJLFEP, n) && !isdefined(@__MODULE__, n)
        @eval import TJLFEP: $n
    end
end

include(joinpath("..", "src", "plotCritGrads_plots.jl"))

end
