#! In this file I collect some of the closed-form solutions I have derived for firms that also sell data, i.e., firms with large customer bases.

"""
    Analytical solution for labor demand.
"""
function labor_demand(D; par::Pars_v3, type::Symbol)
    α_K_hat = get_alpha_K_type(type; par)
    α_L_hat = get_alpha_L_type(type; par)
    (α_L_hat * par.Y^par.α_Y * D^α_K_hat / par.w)^(1 / (1 - α_L_hat))
end
labor_demand(D, type; par::Pars_v3) = labor_demand(D; par, type)

"""
    Analytical Solution when D_S > 0.
"""
function labor_gen(par::Pars_v3; type::Symbol)
    @unpack_Pars_static par
    A_G = A_G_of_type(type; par)
    return ((1 - ϕ) * A_G / (1 - v) * p_D / w_G)^(1 / ϕ)
end

"""
    Formula for the constant ratio between internal and external data for firms that sell data. Internal to External.
"""
function D_E_of_D_I(D_I; par::Pars_v3)
    @unpack_Pars_static par
    return (ξ * (1 - τ) / (1 - v))^ε * D_I
end

"""
    Formula for the constant ratio between internal and external data for firms that sell data. External to Internal.
"""
function D_I_of_D_E(D_E; par::Pars_v3)
    @unpack_Pars_static par
    return (ξ * (1 - τ) / (1 - v))^(-ε) * D_E
end
"""
    Data bundle as a function of external data
"""
D_of_D_E(D_E; par::Pars_v3) = par.c_D * D_E

# """
#     Closed form expression for the data bundle for firms that share data.
# """
# function D_cf(par::Pars_v3; type::Symbol)
#     α_K_hat = get_alpha_K_type(type; par)
#     α_L_hat = get_alpha_L_type(type; par)

#     @unpack_Pars_static par

#     ((α_K_hat*ξ*(α_L_hat/w)^(α_L_hat/(1-α_L_hat))*c_D^(1/ε)*Y^(1/(σ*(1-α_L_hat))))/(p_D/(1-τ)))^((1-α_L_hat)/(1 - α_K_hat - α_L_hat))
# end
# """
#     Closed-Form External Data Demand
# """
# function D_E_cf(par::Pars_v3; type::Symbol)
#     α_K_hat = get_alpha_K_type(type; par)
#     α_L_hat = get_alpha_L_type(type; par)

#     @unpack_Pars_static par
#     con = ((1-v)/(ξ * (1-τ)))^(ε-1) + ξ
#     e = (ε/(ε-1) * α_K_hat - (1-α_L_hat))/(1 - α_K_hat - α_L_hat)

#     return con^e*((α_K_hat*ξ*(α_L_hat/w)^(α_L_hat/(1-α_L_hat))*Y^(1/(σ*(1-α_L_hat))))/(p_D/(1-τ)))^((1-α_L_hat)/(1 - α_K_hat - α_L_hat))
# end

# function D_cf(l; par::Pars_v3, type::Symbol)
#     α_K_hat = get_alpha_K_type(type; par)
#     α_L_hat = get_alpha_L_type(type; par)

#     @unpack_Pars_static par

#     ((α_K_hat*ξ*c_D^(1/ε)*Y^(1/σ)*l^α_L_hat)/(p_D/(1-τ)))^(1/(1-α_K_hat))
# end

# """
#     This factor plays an important role in determining how the price of data changes in response to a tighening of trading frictions.
# """
# function f_tau(par::Pars_v3)
#     @unpack_Pars_static par
#     e = α_S_K_hat/(1 - α_S_K_hat - α_S_L_hat)
#     e2 = α_S_K_hat/((ε-1)*(1-α_S_K_hat - α_S_L_hat))

#     a = (((1-v)/(ξ * (1-τ)))^(ε-1) + ξ)^e2
#     b = (1-τ)^e

#     return a*b
# end

# function f_tau_a_f_tau(par::Pars_v3)
#     @unpack_Pars_static par
#     e = (1 - α_S_L_hat)/(1 - α_S_K_hat - α_S_L_hat) # Here I use the sophisticated α
#     e2 = (ε/(ε-1)*α_S_K_hat-(1 - α_S_L_hat))/(1 - α_S_K_hat - α_S_L_hat)

#     a = (((1-v)/(ξ * (1-τ)))^(ε-1) + ξ)^e2
#     b = (1-τ)^e

#     return (a*b)^α_F/(1-τ)
# end

# """
#     This is a closed-form solution for the case when there is no heterogeneity in terms of sophistication (α_S = α_U) and both firms have sufficient access to internal data such that firms decide to share some data.

#     Seems to be ok, but why does it not yield to correct result? Need to go back and forth between math and code.
# """
# function price_cf(par::Pars_v3)
#     @unpack_Pars_static par
#     @assert α_S_L_hat == α_U_L_hat # Check that there is no heterogeneity in sophistication
#     e = (1 - α_S_L_hat) / (1 - α_S_K_hat - α_S_L_hat)
#     e2 = (α_S_L_hat) / (1 - α_S_L_hat)

#     D_G_B = A_G_B * ((1-ϕ)/(1-v)*(A_G_B/w_G))^((1-ϕ)/ϕ)
#     D_G_S = A_G_S * ((1-ϕ)/(1-v)*(A_G_S/w_G))^((1-ϕ)/ϕ)

#     ((1-v)/ξ * f_tau(par)*(α_S_K_hat * ξ *(α_S_L_hat/w)^e2*Y^(1/(σ*(1-α_S_L_hat))))^e/(0.5*D_G_B + 0.5*D_G_S))^α_F
# end


# """
#     Check whether the data-market clearing condition is correct in its simplified form!

#     D_G and D_E are the SUMS of data generated and external data!
# """
# function market_clearing_2(D_G, D_E;par::Pars_v3)
#     @unpack_Pars_static par
#     D_G - (1-v)/(ξ*(1-τ))*c_D^((ε-1)/ε)*D_E
# end