@with_kw struct Pars_static <: Pars_v3
    #! Deep Parameters
    σ = 2.0  # Elasticity of Substitution
    c = (σ - 1) / σ # auxilary variable
    w_S = 0.5  # Share of Sophisticated Firms
    w_B = 0.5  # Share of Firms with large customer base.
    #α = 0.3  # labor share, knowledge share is 1-α
    ϕ = 0.3  # diminishing returns data generation
    τ = 0.1  # icerberg transportation cost
    v = 0.05 # non-rivalry parameter
    ε = 2    # elasticity of substition data bundle
    ξ = 1.0  # relative usefulness external data

    c_D = (((1-v)/(ξ * (1-τ)))^(ε-1) + ξ)^(ε/(ε-1))# A constant for data bundle of external data. 

    α_S = 0.8  # data share data processing sophisticated, data share is 1-γ
    α_U = 0.6  # data share data processing unsophisticated, data share is 1-γ
    
    α_S_L = 1 - α_S # labor share sophisticated
    α_U_L = 1 - α_U # labor share unsophisticated
    compl_prod::Symbol = :yes
    ζ = 1.0 # Could be tweaked for decreasing aggregate returns, but not implmented in FOCs etc.
    α_Y = set_a_Y(compl_prod, σ, ζ) # auxiliary paramter

    α_S_L_hat = (σ - 1) / σ * α_S_L # adjusted labor factor share sophisticated
    α_S_K_hat = (σ - 1) / σ * α_S # adjusted knowledge factor share sophisticated

    α_U_L_hat = (σ - 1) / σ * α_U_L # adjusted labor factor share unsophisticated
    α_U_K_hat = (σ - 1) / σ * α_U # adjusted knowledge factor share unsophisticated

    α_F = (1/((1-ϕ)/ϕ + (1-α_S_L_hat)/(1-α_S_L_hat-α_S_K_hat)))# A useful constant

    bundle = :yes # Switch in case I want to also implement a version without the data bundle, but making ε very large is similar

    #! Rate of convergence
    λ = 0.1234

    #! Steady State Parameters
    P = 1  # aggregate price level
    #! This is the solution for the model with tau = 0, nu = 0, α_Y = 0
    Y = 2.075300672340325  # aggregate output
    w = 0.2367874818108683  # wage rate good production
    w_G = 0.06021347283561476  # wage rate data generation
    L = 1  # Labor supply for production of the intermediate good
    L_G = 1  # Labor supply for generating / structuring data
    p_D = 0.11356059692613776  # Price of Structured Data
    Ω = 0.0 # data multiplier, generated minus iceberg transportation plus non-rival
    Ω_bundle = 0.0 # data multiplier, bundle relative to generated

    D_G_SS = 0.0 # Total data generated
    D_S_SS = 0.0 # Total data shared


    #! Firm Specific Parameters
    A_G_common = 1.0
    A_G_unsoph = 0.2
    A_P_common = 1.0
    A_P_unsoph = 1.0

    A_G_S = A_G_unsoph * A_G_common # data generation productivity parameter, small
    A_G_B = 1.0 * A_G_common # data generation productivity parameter, big
    A_P_U = A_P_unsoph * A_P_common # data processing productivity parameter, unsophisticated
    A_P_S = 1.0 * A_P_common # data processing productivity parameter, sophisticated

    Firm_sol = 0

    #! Solution Firm-Parameters
    l_LU_ss = 0 # Labor good production small customer base, unsophisticated
    l_BU_ss = 0 # Labor good production big customer base, unsophisticated
    l_LS_ss = 0 # Labor good production small customer base, sophisticated
    l_BS_ss = 0 # Labor good production big customer base, sophisticated

    l_G_LU_ss = 0 # Labor good production small customer base, unsophisticated
    l_G_BU_ss = 0 # Labor good production big customer base, unsophisticated
    l_G_LS_ss = 0 # Labor good production small customer base, sophisticated
    l_G_BS_ss = 0 # Labor good production big customer base, sophisticated

    D_S_LU_ss = 0 # data sharing small customer base, unsophisticated
    D_S_BU_ss = 0 # data sharing big customer base, unsophisticated
    D_S_LS_ss = 0 # data sharing small customer base, sophisticated
    D_S_BS_ss = 0 # data sharing big customer base, sophisticated

    D_G_LU_ss = 0 # data generated small customer base, unsophisticated
    D_G_BU_ss = 0 # data generated big customer base, unsophisticated
    D_G_LS_ss = 0 # data generated small customer base, sophisticated
    D_G_BS_ss = 0 # data generated big customer base, sophisticated

    D_I_LU_ss = 0 # data generated small customer base, unsophisticated
    D_I_BU_ss = 0 # data generated big customer base, unsophisticated
    D_I_LS_ss = 0 # data generated small customer base, sophisticated
    D_I_BS_ss = 0 # data generated big customer base, sophisticated

    D_E_LU_ss = 0 # data generated small customer base, unsophisticated
    D_E_BU_ss = 0 # data generated big customer base, unsophisticated
    D_E_LS_ss = 0 # data generated small customer base, sophisticated
    D_E_BS_ss = 0 # data generated big customer base, sophisticated

    D_LU_ss = 0 # data generated small customer base, unsophisticated
    D_BU_ss = 0 # data generated big customer base, unsophisticated
    D_LS_ss = 0 # data generated small customer base, sophisticated
    D_BS_ss = 0 # data generated big customer base, sophisticated

    K_LU_ss = 0 # knowledge employed small customer base, unsophisticated
    K_BU_ss = 0 # knowledge employed big customer base, unsophisticated
    K_LS_ss = 0 # knowledge employed small customer base, sophisticated
    K_BS_ss = 0 # knowledge employed big customer base, sophisticated

    prof_LU_ss = 0 # knowledge employed small customer base, unsophisticated
    prof_BU_ss = 0 # knowledge employed big customer base, unsophisticated
    prof_LS_ss = 0 # knowledge employed small customer base, sophisticated
    prof_BS_ss = 0 # knowledge employed big customer base, sophisticated
end

@with_kw struct Firm_sol
    #! Solution for firm parameters
    l_LU_ss = 0 # Labor good production small customer base, unsophisticated
    l_BU_ss = 0 # Labor good production big customer base, unsophisticated
    l_LS_ss = 0 # Labor good production small customer base, sophisticated
    l_BS_ss = 0 # Labor good production big customer base, sophisticated

    l_G_LU_ss = 0 # Labor good production small customer base, unsophisticated
    l_G_BU_ss = 0 # Labor good production big customer base, unsophisticated
    l_G_LS_ss = 0 # Labor good production small customer base, sophisticated
    l_G_BS_ss = 0 # Labor good production big customer base, sophisticated

    D_S_LU_ss = 0 # data sharing small customer base, unsophisticated
    D_S_BU_ss = 0 # data sharing big customer base, unsophisticated
    D_S_LS_ss = 0 # data sharing small customer base, sophisticated
    D_S_BS_ss = 0 # data sharing big customer base, sophisticated

    D_G_LU_ss = 0 # data generated small customer base, unsophisticated
    D_G_BU_ss = 0 # data generated big customer base, unsophisticated
    D_G_LS_ss = 0 # data generated small customer base, sophisticated
    D_G_BS_ss = 0 # data generated big customer base, sophisticated

    D_I_LU_ss = 0 # data generated small customer base, unsophisticated
    D_I_BU_ss = 0 # data generated big customer base, unsophisticated
    D_I_LS_ss = 0 # data generated small customer base, sophisticated
    D_I_BS_ss = 0 # data generated big customer base, sophisticated

    D_E_LU_ss = 0 # data generated small customer base, unsophisticated
    D_E_BU_ss = 0 # data generated big customer base, unsophisticated
    D_E_LS_ss = 0 # data generated small customer base, sophisticated
    D_E_BS_ss = 0 # data generated big customer base, sophisticated

    D_LU_ss = 0 # data generated small customer base, unsophisticated
    D_BU_ss = 0 # data generated big customer base, unsophisticated
    D_LS_ss = 0 # data generated small customer base, sophisticated
    D_BS_ss = 0 # data generated big customer base, sophisticated

    D_last_LU = 0 # data generated small customer base, unsophisticated
    D_last_BU = 0 # data generated big customer base, unsophisticated
    D_last_LS = 0 # data generated small customer base, sophisticated
    D_last_BS = 0 # data generated big customer base, sophisticated
    
    prof_LU_ss = 0 # knowledge employed small customer base, unsophisticated
    prof_BU_ss = 0 # knowledge employed big customer base, unsophisticated
    prof_LS_ss = 0 # knowledge employed small customer base, sophisticated
    prof_BS_ss = 0 # knowledge employed big customer base, sophisticated
end