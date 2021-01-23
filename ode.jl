using DifferentialEquations, Plots

# =============================================================================
# Résolution d'une équation différentielle ordinaire (EDO) du 1 ordre    
# Croissance exponentielle (ex en dynamique des populations)    
# Résolution de l'EDO:  du(t)/dt = f(u,p,t) = αu(t) avec u(0) = u₀
# https://fr.wikipedia.org/wiki/%C3%89quation_diff%C3%A9rentielle_ordinaire
# dont on sait que la solution analytique est u(t)=u₀exp(αt)
# =============================================================================
# Paramètres physiques
α = 1.01
# Condtion initiale
u₀ = 0.5
# Domaine temporel
tspan = (0.0, 1.0) # Domaine temporel
# Définition du problème
f(u,p,t) = α * u # fonction en ligne
# Création du problème et résolution
prob = ODEProblem(f, u₀, tspan)
sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8)
# Affichage des résultats
scatter(sol.t, sol.u,title="Résolution d'une EDO de 1er ordre",
     ylim=(0, 1.5),xaxis="t",yaxis="u(t)", m=3, label="Solution numérique") 
plot!(sol.t, t -> 0.5 * exp(α * t), lw=3, label="Solution analytique")

# =============================================================================
# Résolution d'un système d'ODEs du 1 ordre
# Équations de prédation de Lotka-Volterra
# https://fr.wikipedia.org/wiki/%C3%89quations_de_pr%C3%A9dation_de_Lotka-Volterra
# =============================================================================

# Paramètres physiques
p = (2 / 3, 4 / 3, 1.0, 1.0) # liste des paramètres α, β, γ, δ
# Condtions initiales
u₀ = [2.0,1.0]
# Domaine temporel
tspan = (0., 20.) 
# Définition du problème
function lokta_volterra(du, u, p, t)
    lap, lou = u
    α, β, γ, δ = p
    du[1] = α * lap - β * lap * lou # Ière EDO pour les proies
    du[2] = δ * lap * lou - γ * lou # 2nd EDO pour les prédateurs
end
# Création du problème et résolution
prob = ODEProblem(lokta_volterra, u₀, tspan, p)
sol = solve(prob)
# Affichage des résultats
plot(sol)

# =============================================================================
# Pendule Simple
# https://fr.wikipedia.org/wiki/Pendule_simple
# =============================================================================
#= Rappel Théorique 
Pour une masse ponctuelle en rotation autour d'un axe et à une distance L de celui-ci, l'équation de moment  de la seconde loi de Newton s'écrit  
∑M₀ = J₀ d²θ/dt² avec J₀ = mL²       
la force de rappel étant -mgsin(θ), on trouve l'équation différentielle ordinaire suivante:
d²θ/dt²+g/L*sin(θ) = 0 
θ étant supposé petit (sin(θ)≈θ) et en posant K = g/L, l'équation précédente s'écrit :
d²θ/dt²+K*θ = 0 
avec dθ/dt = ω(t)
La solution analytique s'écrit :
θ = (ω₀/√K)*sin(√K*t) + θ₀*cos(√K*t)
ω = ω₀*cos(√K*t) -θ₀√K*sin(√K*t) =#

using Measurements # pour les incertitudes

# Paramètres physiques
g = 9.8  ± 0.01           # accélération de la pesanteur en m/s² 
L = 1.0  ± 0.01  # longueur du pendule en m
K = g / L # raideur équivalente
p = (K) # liste des paramètres
# Conditions initiales 
θ₀ = 0.1  ± 0.01
ω₀ = 0.1  ± 0.0
u₀ = [θ₀, ω₀] # angle initial et vitesse angulaire initiale
# Domaine temporel
tspan = (0.0, 2π)
# Définition du problème
function pendulesimple(du, u, p, t) # u[1]=θ, u[2]=dθ
    K = p
    du[1] = u[2] # θ'(t) = ω(t)
    du[2] = - K * u[1] #  θ''(t) = ω'(t) = -g/L*θ(t) 
end
# Création du problème et résolution
prob = ODEProblem(pendulesimple, u₀, tspan, p)
sol = solve(prob,  Tsit5(), reltol=1e-8, abstol=1e-8)
# Affichage des résultats
θ_plot = scatter(sol.t, getindex.(sol.u, 1), m=3, xlabel="t [s]", ylabel="θ [rad]", label="Solution numérique")
u1 = u₀[2] / (sqrt(K)) .* sin.(sqrt(K) .* sol.t)+u₀[1] .* cos.(sqrt(K) .* sol.t)
θ_plot = plot!(sol.t, u1, lw=3, label="Solution analytique")
ω_plot = scatter(sol.t, getindex.(sol.u, 2), m=3, xlabel="t [s]", ylabel="ω [rad/s]", label="Solution numérique")
u2 = u₀[2] .* cos.(sqrt(K) .* sol.t) - u₀[1] * sqrt(K) .* sin.(sqrt(K) .* sol.t)
ω_plot = plot!(sol.t, u2, lw=3, xlabel="t [s]", ylabel="ω [rad/s]", label="Solution analytique")
plot(θ_plot, ω_plot, layout=(2, 1))

