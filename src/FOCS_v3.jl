"""
    First order condition for data generation
"""
function FOC_data_gen(l_G, D, l, D_I; par::Pars_v3, type::Symbol)
    @unpack_Pars_static par
    @assert type in [:LU, :LS, :BU, :BS]

    D_G = data_gen(l_G; par, type)
    Π = firm_revenue(D, l; par, type)
    α_K_hat = get_alpha_K_type(type; par)

    α_K_hat * (1 - ϕ) * D_G / l_G * Π / D * dD_dDI(D, D_I; par) - w_G
end

"""
    First order condition for intermediate good labor
"""
function FOC_data_proc(l_P, D, l; par::Pars_v3, type::Symbol, sec_period::Symbol=:no)
    @unpack_Pars_static par
    @assert type in [:LU, :LS, :BU, :BS]

    γ = gamma_of_type(par; type)
    Π = firm_revenue(l_P, D, l; par, type)
    if sec_period == :no
        α_K_hat * γ * Π / l_P - w_P
    elseif sec_period == :yes
        α_K_hat * γ * Π / l_P - w_P2
    end
end

"""
    First order condition for data sharing
"""
function FOC_data_sharing(D, DI, l; par::Pars_static, type::Symbol)
    @unpack_Pars_static par
    @assert type in [:LU, :LS, :BU, :BS]

    Π = firm_revenue(D, l; par, type)
    α_K_hat = get_alpha_K_type(type; par)
    p_D - α_K_hat * Π / D * dD_dDS(D, DI; par) #! does this seem correct?
end

"""
    First order condition for data buying
"""
function FOC_data_buying(D, l, DE; par::Pars_v3, type::Symbol)
    @unpack_Pars_static par
    @assert type in [:LU, :LS, :BU, :BS]

    Π = firm_revenue(D, l; par, type)
    α_K_hat = get_alpha_K_type(type; par)
    α_K_hat * Π / D * dD_dDE(D, DE; par) - p_D / (1 - τ)
end
"""
    Marginal product of Data
"""
function MPD(D, l; par::Pars_v3, type::Symbol)
    α_K_hat = get_alpha_K_type(type; par)
    Π = firm_revenue(D, l; par, type)
    α_K_hat * Π / D
end

"""
    Derivative of the data bundle D with respect to internal Data.
"""
dD_dDI(D, DI; par::Pars_v3) = (D / DI)^(1 / par.ε)
"""
    Derivative of the data bundle D with respect to Data Sharing.
"""
dD_dDS(D, DI; par::Pars_v3) = (1 - par.v) * (D / DI)^(1 / par.ε)
"""
    Derivative of the data bundle D with respect to external Data.
"""
dD_dDE(D, DE; par::Pars_v3) = par.ξ * (D / DE)^(1 / par.ε)
"""
    Derivative of the data bundle D with respect to analyst labor
"""
dD_dlG(D, l_G, DI; par::Pars_v3, type::Symbol) = (1 - par.ϕ) * data_gen(l_G; par, type) / l_G * (D / DI)^(1 / par.ε)


"""
    First order condition for intermediate good labor
"""
function FOC_int_labor(l_P, D, l; par::Pars_v3, type::Symbol, sec_period::Symbol=:no)
    @unpack_Pars_static par
    @assert type in [:LU, :LS, :BU, :BS]

    Π = firm_revenue(l_P, D, l; par, type)
    if sec_period == :no
        α_L_hat * Π / l - w
    elseif sec_period == :yes
        α_L_hat * Π / l - w2
    end
    #K = knowledge(l_P, D; par, type)
    #Y^α_Y * α_L_hat * K^α_K_hat * l^(α_L_hat - 1) - w
end

"""
    The value of the data bundle using both internal and external data.
"""
function bundle(D_I, D_E; par::Pars_v3, type = nothing)
    (D_I^((par.ε - 1) / par.ε) + par.ξ * D_E^((par.ε - 1) / par.ε))^(par.ε / (par.ε - 1))
end

data_multiplier(D_G, D_S; par::Pars_v3) = 1 - (par.τ - par.v) * D_S / D_G
data_multiplier_bundle(D, D_G) = D / D_G


function knowledge(l_P, D; par::Pars_v3, type::Symbol, sec_period::Symbol=:no)
    A_P = A_P_of_type(type; par)
    γ = gamma_of_type(par; type)
    K_last = K_last_of_type(par; type)
    if sec_period == :yes
        A_P * l_P^γ * D^(1 - γ) + (1 - par.δ_K) * K_last
    elseif sec_period == :no
        A_P * l_P^γ * D^(1 - γ)
    else
        error("second_period needs to be either :yes or :no")
    end
end

knowledge(l_P, D, type::Symbol; par::Pars_v3, sec_period::Symbol=:no) = knowledge(l_P, D; par, type, sec_period)

function data_gen(l_G; par::Pars_v3, type::Symbol)
    A_G = A_G_of_type(type; par)
    A_G * l_G^(1 - par.ϕ)
end
data_gen(l_G, type::Symbol; par::Pars_v3) = data_gen(l_G; par, type)
data_intern(D_G, D_S; par::Pars_v3) = D_G - (1 - par.v) * D_S


function sold_data(D_I, l_G; par::Pars_v3, type::Symbol)
    D_G = data_gen(l_G; par, type)

    return (D_G - D_I) / (1 - par.v)
end

sold_data(D_I, l_G, type; par::Pars_v3) = sold_data(D_I, l_G; par, type)

"""
    output = Y_i = K^α*l^(1-α)
"""
function firm_output(D, l; par::Pars_v3, type::Symbol)
    α_K = get_alpha_K_type_normal(type; par)
    #! This here is incorrect!
    D^α_K * l^(1 - α_K)
end
firm_output(D, l, type; par::Pars_v3) = firm_output(D, l; par, type)

"""
    revenue = p_i * Y_i. Seems ok
"""
function firm_revenue(D, l; par::Pars_v3, type::Symbol)
    α_K_hat = get_alpha_K_type(type; par)
    α_L_hat = get_alpha_L_type(type; par)
    par.Y^par.α_Y * D^α_K_hat * l^α_L_hat
end

firm_revenue(D, l, type; par::Pars_v3) = firm_revenue(D, l; par, type)

"""
    Firm profits
"""
function firm_profits(l, l_G, D_S, D_E; par::Pars_v3, type::Symbol)
    D_G = data_gen(l_G; par, type)
    D_I = data_intern(D_G, D_S; par)
    D = bundle(D_I, D_E; par, type)
    Π = firm_revenue(D, l; par, type)
    Π - par.w * l - par.w_G * l_G + par.p_D * D_S - par.p_D / (1 - par.τ) * D_E
end

firm_profits(l, l_G, D_S, D_E, type::Symbol; par::Pars_v3) = firm_profits(l, l_G, D_S, D_E; par, type)