module ConsumerDataCCPA
using CompEcon, Parameters, Setfield, Optim, NLsolve
using QuantEcon: gridmake
#using StatsFuns: normcdf
using Roots: find_zero
#pgfplotsx()

# This is the main abstract structure 
abstract type Pars_v3 end

#! Static Code
include("Types.jl")
include("Functions_v3.jl")
include("FOCS_v3.jl")

include("Auxiliary_Funcs.jl")
include("Wages.jl")
include("Residuals.jl")
include("ClosedForms.jl")

export comp_statics, Pars_static, @unpack_Pars_static, Firm_sol, @unpack_Firm_sol
end # module
