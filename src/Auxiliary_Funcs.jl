"""
    Calculate firm variables and populate struct with steady state values.
"""
function Save_Firm_Solution(l, l_G, D_I, D_E, D; par::Pars_v3)
    type = [:BS, :LS, :LU, :BU]

    D_S = sold_data.(D_I, l_G, type; par)
    D_G = data_gen.(l_G, type; par)
    prof = firm_profits.(l, l_G, D_S, D_E, type; par)
    res = Firm_sol()
    @set! res.prof_BS_ss = prof[1] # Labor good production big customer base, sophisticated
    @set! res.prof_LS_ss = prof[2] # Labor good production small customer base, sophisticated
    @set! res.prof_LU_ss = prof[3] # Labor good production small customer base, unsophisticated
    @set! res.prof_BU_ss = prof[4] # Labor good production big customer base, unsophisticated

    @set! res.l_BS_ss = l[1] # Labor good production big customer base, sophisticated
    @set! res.l_LS_ss = l[2] # Labor good production small customer base, sophisticated
    @set! res.l_LU_ss = l[3] # Labor good production small customer base, unsophisticated
    @set! res.l_BU_ss = l[4] # Labor good production big customer base, unsophisticated

    @set! res.l_G_BS_ss = l_G[1] # Labor good production big customer base, sophisticated
    @set! res.l_G_LS_ss = l_G[2] # Labor good production small customer base, sophisticated
    @set! res.l_G_LU_ss = l_G[3] # Labor good production small customer base, unsophisticated
    @set! res.l_G_BU_ss = l_G[4] # Labor good production big customer base, unsophisticated

    @set! res.D_S_BS_ss = D_S[1] # data sharing big customer base, sophisticated
    @set! res.D_S_LS_ss = D_S[2] # data sharing small customer base, sophisticated
    @set! res.D_S_LU_ss = D_S[3] # data sharing small customer base, unsophisticated
    @set! res.D_S_BU_ss = D_S[4] # data sharing big customer base, unsophisticated

    @set! res.D_G_BS_ss = D_G[1] # data generated big customer base, sophisticated
    @set! res.D_G_LS_ss = D_G[2] # data generated small customer base, sophisticated
    @set! res.D_G_LU_ss = D_G[3] # data generated small customer base, unsophisticated
    @set! res.D_G_BU_ss = D_G[4] # data generated big customer base, unsophisticated

    @set! res.D_BS_ss = D[1] # data generated big customer base, sophisticated
    @set! res.D_LS_ss = D[2] # data generated small customer base, sophisticated
    @set! res.D_LU_ss = D[3] # data generated small customer base, unsophisticated
    @set! res.D_BU_ss = D[4] # data generated big customer base, unsophisticated

    @set! res.D_E_BS_ss = D_E[1] # data generated big customer base, sophisticated
    @set! res.D_E_LS_ss = D_E[2] # data generated small customer base, sophisticated
    @set! res.D_E_LU_ss = D_E[3] # data generated small customer base, unsophisticated
    @set! res.D_E_BU_ss = D_E[4] # data generated big customer base, unsophisticated

    @set! res.D_I_BS_ss = D_I[1] # data generated big customer base, sophisticated
    @set! res.D_I_LS_ss = D_I[2] # data generated small customer base, sophisticated
    @set! res.D_I_LU_ss = D_I[3] # data generated small customer base, unsophisticated
    @set! res.D_I_BU_ss = D_I[4] # data generated big customer base, unsophisticated

    return res
end

function get_alpha_K_type(type::Symbol;par::Pars_v3)
    if type == :LU # little, unsophisticated
        par.α_U_K_hat
    elseif type == :LS # little, sophisticated
        par.α_S_K_hat
    elseif type == :BU # big, unsophisticated
        par.α_U_K_hat
    elseif type == :BS # big, sophisticated
        par.α_S_K_hat
    else
        error("Firm type needs to be either LU, LS, BU or BS")
    end
end

function get_alpha_K_type_normal(type::Symbol;par::Pars_v3)
    if type == :LU # little, unsophisticated
        par.α_U
    elseif type == :LS # little, sophisticated
        par.α_S
    elseif type == :BU # big, unsophisticated
        par.α_U
    elseif type == :BS # big, sophisticated
        par.α_S
    else
        error("Firm type needs to be either LU, LS, BU or BS")
    end
end

function get_alpha_L_type(type::Symbol;par::Pars_v3)
    if type == :LU # little, unsophisticated
        par.α_U_L_hat
    elseif type == :LS # little, sophisticated
        par.α_S_L_hat
    elseif type == :BU # big, unsophisticated
        par.α_U_L_hat
    elseif type == :BS # big, sophisticated
        par.α_S_L_hat
    else
        error("Firm type needs to be either LU, LS, BU or BS")
    end
end

function weight_of_type(type::Symbol; par::Pars_v3)
    if type == :LU # little, unsophisticated
        (1 - par.w_B) * (1 - par.w_S)
    elseif type == :LS # little, sophisticated
        (1 - par.w_B) * par.w_S
    elseif type == :BU # big, unsophisticated
        par.w_B * (1 - par.w_S)
    elseif type == :BS # big, sophisticated
        par.w_B * par.w_S
    else
        error("Firm type needs to be either LU, LS, BU or BS")
    end
end

"""
    Data Generation Productivity / Customer Base depending on type.
"""
function A_G_of_type(type::Symbol; par::Pars_v3)
    if type == :LU # little, unsophisticated
        par.A_G_S
    elseif type == :LS # little, sophisticated
        par.A_G_S
    elseif type == :BU # big, unsophisticated
        par.A_G_B
    elseif type == :BS # big, sophisticated
        par.A_G_B
    else
        error("Firm type needs to be either LU, LS, BU or BS")
    end
end

"""
    Squares the minimizer and returns the solution values
"""
function get_solution(sol; par::Pars_v3, type::Symbol)
    if length(sol.minimizer) == 4
        l_P = sol.minimizer[1]^2
        l_G = sol.minimizer[2]^2
        D_E = sol.minimizer[3]^2
        D_I = sol.minimizer[4]^2
        D = bundle(D_I, D_E; par, type)
        l = labor_demand(l_P, D; par, type)
    elseif length(sol.minimizer) == 3
        l_P = sol.minimizer[1]^2
        l_G = sol.minimizer[2]^2
        D_E = sol.minimizer[3]^2
        D_I = data_gen(l_G; par, type)
        D = bundle(D_I, D_E; par, type)
        l = labor_demand(l_P, D; par, type)
    else
        error("I should never be here")
    end

    return l_P, l_G, l, D_E, D_I, D
end

function get_solution_nl_unc(sol; par::Pars_v3, type::Symbol)
    l_G = sol.zero[1]^2
    D_E = sol.zero[2]^2
    D_I = sol.zero[3]^2
    D = bundle(D_I, D_E; par, type)
    l = labor_demand(D; par, type)

    return l_G, l, D_E, D_I, D
end

function get_solution_nl_con(sol; par::Pars_v3, type::Symbol)
    l_G = sol.zero[1]^2
    D_E = sol.zero[2]^2
    D_I = data_gen(l_G; par, type)
    D = bundle(D_I, D_E; par, type)
    l = labor_demand(D; par, type)
    return l_G, l, D_E, D_I, D
end

function set_a_Y(compl_prod, σ, ζ)
    if compl_prod == :yes
        α_Y = (σ * ζ - σ + 1) / (σ * ζ) # auxiliary paramter
    elseif compl_prod == :no
        α_Y = 0
    else
        error("Field compl_prod needs to be either :no or :yes")
    end
    return α_Y
end

"""
    Return the correct gamma
"""
function gamma_of_type(par::Pars_v3; type::Symbol)
    if type in [:BS, :LS]
        par.γ_S
    elseif type in [:BU, :LU]
        par.γ_U
    else
        error("type needs to be either :BS, :LS, :BU or :LU")
    end
end
