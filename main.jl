using ConsumerDataCCPA
cd(@__DIR__)

"""
    Function to export graphs directly to a pdf and png.
"""
function plot_comp_static_firm(x, y; xlabel="", ylabel="", Filename::String)
    y_LU = y[1]
    y_BU = y[2]
    y_LS = y[3]
    y_BS = y[4]

    plot(x, y_LU ./ y_LU[1], xlabel=xlabel, ylabel=ylabel, label="Small, unsophisticated", color=:black, ls=:dash)
    plot!(x, y_BU ./ y_BU[1], color=:black, label="Big, unsophisticated")
    plot!(x, y_LS ./ y_LS[1], color=:red, ls=:dash, label="Small, sophisticated")
    plot!(x, y_BS ./ y_BS[1], color=:red, label="Big, sophisticated")

    savefig("Graphs/" * Filename * "_normalized.pdf")
    savefig("Graphs/" * Filename * "_normalized.png")

    plot(x, y_LU, color=:black, ls=:dash, xlabel=xlabel, ylabel=ylabel, label="Small, unsophisticated")
    plot!(x, y_BU, color=:black, label="Big, unsophisticated")
    plot!(x, y_LS, color=:red, ls=:dash, label="Small, sophisticated")
    plot!(x, y_BS, color=:red, label="Big, sophisticated")

    savefig("Graphs/" * Filename * ".pdf")
    savefig("Graphs/" * Filename * ".png")
end

"""
    Function to generate individual plot objects that are then combined in subplots.
"""
function plot_comp_static_firm_export(x, y; xlabel="", ylabel="", legend=:no, norm=:no)
    if norm == :yes
        y_LU = y[1] ./ y[1][1]
        y_BU = y[2] ./ y[2][1]
        y_LS = y[3] ./ y[3][1]
        y_BS = y[4] ./ y[4][1]
    elseif norm == :reverse
        y_LU = y[1] ./ y[1][end]
        y_BU = y[2] ./ y[2][end]
        y_LS = y[3] ./ y[3][end]
        y_BS = y[4] ./ y[4][end]
    elseif norm == :no
        y_LU = y[1]
        y_BU = y[2]
        y_LS = y[3]
        y_BS = y[4]
    else
        error("Keyword norm needs to be either :yes, :no, or :reverse")
    end

    if legend == :no
        p = plot(x, y_LU, color=:black, ls=:dash, xlabel=xlabel, ylabel=ylabel, label="")
        plot!(x, y_BU, color=:black, label="")
        plot!(x, y_LS, color=:red, ls=:dash, label="")
        plot!(x, y_BS, color=:red, label="")
    elseif legend == :yes
        p = plot(x, y_LU, color=:black, ls=:dash, xlabel=xlabel, ylabel=ylabel, label="Small, unsophisticated")
        plot!(x, y_BU, color=:black, label="Big, unsophisticated")
        plot!(x, y_LS, color=:red, ls=:dash, label="Small, sophisticated")
        plot!(x, y_BS, color=:red, label="Big, sophisticated")
    end
    return p
end

using Measures, Plots
Plots.scalefontsizes(1.4) 
gr()

include("Script_CompStatics/A_G_GE.jl")
include("Script_CompStatics/Nu_GE.jl")
include("Script_CompStatics/Tau_GE.jl")
include("Script_CompStatics/Xi_GE.jl")
