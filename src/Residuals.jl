function residuals_unc_nl(x, res; par::Pars_v3, type::Symbol)
    l_G = x[1]^2
    D_E = x[2]^2
    D_I = x[3]^2

    D = bundle(D_I, D_E; par, type)
    l = labor_demand(D; par, type)

    #! FOCs
    res[1] = FOC_data_buying(D, l, D_E; par, type)
    res[2] = FOC_data_gen(l_G, D, l, D_I; par, type)
    res[3] = FOC_data_sharing(D, D_I, l; par, type)

    return res # Try to force the algorithm to come up with something more precise
end

"""
    Constrained residuals, D_S = 0, no data selling.
"""
function residuals_con_nl(x, res; par::Pars_v3, type::Symbol)
    l_G = x[1]^2
    D_E = x[2]^2

    D_I = data_gen(l_G; par, type)
    D = bundle(D_I, D_E; par, type)
    l = labor_demand(D; par, type)

    #! FOCs
    res[1] = FOC_data_buying(D, l, D_E; par, type)
    res[2] = FOC_data_gen(l_G, D, l, D_I; par, type)
    #res[3] = FOC_data_proc(D, l; par, type)

    return res
end

"""
    Data market clearing condition
"""
function data_market_clearing(l_G, D_E, D_I; par::Pars_v3)
    l_G_BS = l_G[1]
    l_G_LS = l_G[2]
    l_G_LU = l_G[3]
    l_G_BU = l_G[4]

    D_E_BS = D_E[1]
    D_E_LS = D_E[2]
    D_E_LU = D_E[3]
    D_E_BU = D_E[4]

    D_I_BS = D_I[1]
    D_I_LS = D_I[2]
    D_I_LU = D_I[3]
    D_I_BU = D_I[4]

    D_S_BS = sold_data(D_I_BS, l_G_BS; par, type = :BS)
    D_S_LS = sold_data(D_I_LS, l_G_LS; par, type = :LS)
    D_S_LU = sold_data(D_I_LU, l_G_LU; par, type = :LU)
    D_S_BU = sold_data(D_I_BU, l_G_BU; par, type = :BU)

    w_BS = weight_of_type(:BS; par)
    w_LS = weight_of_type(:LS; par)
    w_LU = weight_of_type(:LU; par)
    w_BU = weight_of_type(:BU; par)

    D_S = w_BS * D_S_BS + w_LS * D_S_LS + w_LU * D_S_LU + w_BU * D_S_BU
    D_B = w_BS * D_E_BS + w_LS * D_E_LS + w_LU * D_E_LU + w_BU * D_E_BU
    #! 1-τ times all data sold is equal to what is bought
    return D_S * (1 - par.τ) - D_B
end

function residuals_p_D(p_D; par::Pars_v3)

    @set! par.p_D = p_D

    l_G_BS, l_BS, D_E_BS, D_I_BS, D_BS = sol_f_problem_nl(par, type = :BS)
    l_G_LS, l_LS, D_E_LS, D_I_LS, D_LS = sol_f_problem_nl(par, type = :LS)
    l_G_LU, l_LU, D_E_LU, D_I_LU, D_LU = sol_f_problem_nl(par, type = :LU)
    l_G_BU, l_BU, D_E_BU, D_I_BU, D_BU = sol_f_problem_nl(par, type = :BU)

    l_G = [l_G_BS, l_G_LS, l_G_LU, l_G_BU]
    D_E = [D_E_BS, D_E_LS, D_E_LU, D_E_BU]
    D_I = [D_I_BS, D_I_LS, D_I_LU, D_I_BU]

    data_market_clearing(l_G, D_E, D_I; par)
end