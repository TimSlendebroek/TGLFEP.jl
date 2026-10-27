# make_crit_grad_plots lives in ext/TJLFEPPlotsExt.jl (Plots is a weak dependency)
using Test
using TJLFEP

const CRIT_DIR = mktempdir()
TJLFEP.write_crit_grad(joinpath(CRIT_DIR, "alpha_dpdr_crit.input"), "Pressure gradient", [1.0, 1.5, 2.5, 4.0])
TJLFEP.write_crit_grad(joinpath(CRIT_DIR, "alpha_dndr_crit.input"), "Density gradient", [0.2, 0.4, 0.9, 1.3])

@testset "crit-grad plots without Plots" begin
    if any(k.name == "Plots" for k in keys(Base.loaded_modules))
        @test_skip "Plots already loaded in this session"
    else
        @test Base.get_extension(TJLFEP, :TJLFEPPlotsExt) === nothing
        @test isempty(methods(TJLFEP.make_crit_grad_plots))
    end
end

ENV["GKSwstype"] = "nul" # headless GR
using Plots

@testset "crit-grad plots with Plots" begin
    @test Base.get_extension(TJLFEP, :TJLFEPPlotsExt) !== nothing
    TJLFEP.make_crit_grad_plots(; dir=CRIT_DIR) # default code="auto" reads write_crit_grad's Fortran layout
    for f in ("alpha_dpdr_crit.png", "alpha_dndr_crit.png", "normalized_crit_grads.png")
        @test isfile(joinpath(CRIT_DIR, f))
    end
end
