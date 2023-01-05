τ_set = [0.2]
v_set = [0.3]
A_G_common_set = [1.0]
ξ_set = collect(0.5:0.05:1.0)
pars = comp_statics(τ_set, v_set, A_G_common_set, ξ_set; tol = 1e-12)

xlabel = L"External Data-Quality $\xi^{-1}$"

prof_LU = [par.prof_LU_ss for par in pars]
prof_BU = [par.prof_BU_ss for par in pars]
prof_LS = [par.prof_LS_ss for par in pars]
prof_BS = [par.prof_BS_ss for par in pars]

addon = "_xi_GE"

x = 1 ./ξ_set

plot_comp_static_firm(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel = xlabel, ylabel = "Profits", Filename = "Profits"*addon)

D_LU = [par.D_LU_ss for par in pars]
D_BU = [par.D_BU_ss for par in pars]
D_LS = [par.D_LS_ss for par in pars]
D_BS = [par.D_BS_ss for par in pars]

plot_comp_static_firm(x, [D_LU, D_BU, D_LS, D_BS]; xlabel = xlabel, ylabel = "Data Bundle", Filename = "DataBundle"*addon)

D_I_LU = [par.D_I_LU_ss for par in pars]
D_I_BU = [par.D_I_BU_ss for par in pars]
D_I_LS = [par.D_I_LS_ss for par in pars]
D_I_BS = [par.D_I_BS_ss for par in pars]

plot_comp_static_firm(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel = xlabel, ylabel = "Internal Data", Filename = "Internal_Data"*addon)

D_E_LU = [par.D_E_LU_ss for par in pars]
D_E_BU = [par.D_E_BU_ss for par in pars]
D_E_LS = [par.D_E_LS_ss for par in pars]
D_E_BS = [par.D_E_BS_ss for par in pars]

plot_comp_static_firm(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel = xlabel, ylabel = "External Data", Filename = "External_Data"*addon)

D_S_LU = [par.D_S_LU_ss for par in pars]
D_S_BU = [par.D_S_BU_ss for par in pars]
D_S_LS = [par.D_S_LS_ss for par in pars]
D_S_BS = [par.D_S_BS_ss for par in pars]

D_S = [par.D_S_SS for par in pars]
D_G = [par.D_G_SS for par in pars]

plot_comp_static_firm(x, [D_S_LU, D_S_BU, D_S_LS, D_S_BS]; xlabel = xlabel, ylabel = "Shared Data", Filename = "Shared_Data"*addon)

p_D_nu = [par.p_D for par in pars]
p_D_nu_2 = [par.p_D/(1-par.τ) for par in pars]
w_G_nu = [par.w_G for par in pars]
w_nu = [par.w for par in pars]
Y_nu = [par.Y for par in pars]

p1 = plot(x, [p_D_nu, p_D_nu_2], ylabel = L"Price of Data $p^D$", label = ["Sell Price" "Buy Price"], color = [:black :red], ls = [:solid :dash], legend = :topleft,right_margin = 1cm)
p3 = plot(x, w_G_nu, ylabel = L"Wage Gathering $w_G$", label = "", color = :black)
p4 = plot(x, w_nu, ylabel=L"Wage $w$", label="", color=:black, right_margin=1cm)
p5 = plot(x, Y_nu, ylabel = L"Aggregate Output $Y$", label = "", color = :black)

plot(p1, p3, p4, p5, size = (800, 600), color = :black, xlabel = xlabel)

savefig("Graphs/Aggregate"*addon*".pdf")
savefig("Graphs/Aggregate"*addon*".png")

p1 = plot_comp_static_firm_export(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel = xlabel, ylabel = "Profits")

p1_norm = plot_comp_static_firm_export(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel = xlabel, ylabel = "Normalized Profits", norm = :reverse, legend = :yes)

plot(p1, p1_norm, legend = :bottomleft, size = (1000, 400))
savefig("Graphs/FirmGraphProfits"*addon*".png")
savefig("Graphs/FirmGraphProfits"*addon*".pdf")

p2 = plot_comp_static_firm_export(x, [D_LU, D_BU, D_LS, D_BS]; xlabel = xlabel, ylabel = "Data Bundle")

p4 = plot_comp_static_firm_export(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel = xlabel, ylabel = "Internal Data")

p4_norm = plot_comp_static_firm_export(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel = xlabel, ylabel = "Internal Data", norm = :reverse)

p5 = plot_comp_static_firm_export(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel = xlabel, ylabel = "External Data")

p5_norm = plot_comp_static_firm_export(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel = xlabel, ylabel = "External Data", norm = :reverse, legend = :yes)

plot(p4_norm, p5_norm, legend = :topright, size = (1000, 400))

savefig("Graphs/FirmGraphDataNorm"*addon*".png")
savefig("Graphs/FirmGraphDataNorm"*addon*".pdf")

p6 = plot_comp_static_firm_export(x, [D_S_LU, D_S_BU, D_S_LS, D_S_BS]; xlabel = xlabel, ylabel = "Shared Data")

plot(p5, p4, p2, size = (1200, 300), legend = (-0.4, -0.3), layout = (1,3))

savefig("Graphs/FirmGraphData"*addon*".png")
savefig("Graphs/FirmGraphData"*addon*".pdf")