τ_set = [0.2]
v_set = [0.1]
ξ_set = [1.0]
A_G_common_set = collect(0.8:0.01:1.00)
Folder = "GE"
pars = comp_statics(τ_set, v_set, A_G_common_set, ξ_set; tol=1e-12)
x = reverse(1 ./ A_G_common_set)
reverse!(pars)
xlabel = L"Customer Base $1/A_G$"

prof_LU = [par.prof_LU_ss for par in pars]
prof_BU = [par.prof_BU_ss for par in pars]
prof_LS = [par.prof_LS_ss for par in pars]
prof_BS = [par.prof_BS_ss for par in pars]

plot_comp_static_firm(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel=xlabel, ylabel="Profits", Filename="Profits_A_G_GE")

D_LU = [par.D_LU_ss for par in pars]
D_BU = [par.D_BU_ss for par in pars]
D_LS = [par.D_LS_ss for par in pars]
D_BS = [par.D_BS_ss for par in pars]

plot_comp_static_firm(x, [D_LU, D_BU, D_LS, D_BS]; xlabel=xlabel, ylabel="Data Bundle", Filename="DataBundle_A_G_GE")

D_I_LU = [par.D_I_LU_ss for par in pars]
D_I_BU = [par.D_I_BU_ss for par in pars]
D_I_LS = [par.D_I_LS_ss for par in pars]
D_I_BS = [par.D_I_BS_ss for par in pars]

plot_comp_static_firm(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel=xlabel, ylabel="Internal Data", Filename="Internal_Data_A_G_GE")

D_E_LU = [par.D_E_LU_ss for par in pars]
D_E_BU = [par.D_E_BU_ss for par in pars]
D_E_LS = [par.D_E_LS_ss for par in pars]
D_E_BS = [par.D_E_BS_ss for par in pars]

plot_comp_static_firm(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel=xlabel, ylabel="External Data", Filename="External_Data_A_G_GE")

D_S_LU = [par.D_S_LU_ss for par in pars]
D_S_BU = [par.D_S_BU_ss for par in pars]
D_S_LS = [par.D_S_LS_ss for par in pars]
D_S_BS = [par.D_S_BS_ss for par in pars]

D_S = [par.D_S_SS for par in pars]
D_G = [par.D_G_SS for par in pars]

plot_comp_static_firm(x, [D_S_LU, D_S_BU, D_S_LS, D_S_BS]; xlabel=xlabel, ylabel="Shared Data", Filename="Shared_Data_A_G_GE")

p_D = [par.p_D for par in pars]
p_D_A_G_2 = [par.p_D / (1 - par.τ) for par in pars]
w_G = [par.w_G for par in pars]
w = [par.w for par in pars]
Y = [par.Y for par in pars]

p1 = plot(x, [p_D, p_D_A_G_2], ylabel=L"Price of Data $p^D$", label=["Sell Price" "Buy Price"], color=[:black :red], ls=[:solid :dash], legend=:left, right_margin=1cm)
p3 = plot(x, w_G, ylabel=L"Wage Gathering $w_G$", label="", color=:black)
p4 = plot(x, w, ylabel=L"Wage $w_Y$", label="", color=:black, right_margin=1cm)
p5 = plot(x, Y, ylabel=L"Aggregate Output $Y$", label="", color=:black)

plot(p1, p3, p4, p5, size=(800, 600), color=:black, xlabel=xlabel)

savefig("Graphs/Aggregate_GE_A_G.pdf")
savefig("Graphs/Aggregate_GE_A_G.png")

p1 = plot_comp_static_firm_export(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel=xlabel, ylabel="Profits")

p1_norm = plot_comp_static_firm_export(x, [prof_LU, prof_BU, prof_LS, prof_BS]; xlabel=xlabel, ylabel="Normalized Profits", norm=:yes, legend=:yes)

plot(p1, p1_norm, legend=:bottomleft, size=(1000, 400))
savefig("Graphs/FirmGraphProfits_GE_A_G.png")
savefig("Graphs/FirmGraphProfits_GE_A_G.pdf")

p2 = plot_comp_static_firm_export(x, [D_LU, D_BU, D_LS, D_BS]; xlabel=xlabel, ylabel="Data Bundle")

p4 = plot_comp_static_firm_export(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel=xlabel, ylabel="Internal Data")

p4_norm = plot_comp_static_firm_export(x, [D_I_LU, D_I_BU, D_I_LS, D_I_BS]; xlabel=xlabel, ylabel="Internal Data",  norm=:yes)

p5 = plot_comp_static_firm_export(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel=xlabel, ylabel="External Data")

p5_norm = plot_comp_static_firm_export(x, [D_E_LU, D_E_BU, D_E_LS, D_E_BS]; xlabel=xlabel, ylabel="External Data",  norm=:yes, legend=:yes)

plot(p4_norm, p5_norm, legend=:topright, size=(1000, 400))

savefig("Graphs/FirmGraphDataNorm_GE_A_G.png")
savefig("Graphs/FirmGraphDataNorm_GE_A_G.pdf")

p6 = plot_comp_static_firm_export(x, [D_S_LU, D_S_BU, D_S_LS, D_S_BS]; xlabel=xlabel, ylabel="Shared Data")

plot(p5, p4, p2, size=(1200, 300), legend=(-0.4, -0.3), layout=(1, 3))

savefig("Graphs/FirmGraphData_GE_A_G.png")
savefig("Graphs/FirmGraphData_GE_A_G.pdf")
