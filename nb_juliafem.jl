### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 3f3ea480-4dc8-11eb-2ae0-effbf35a2819
begin 
	using BenchmarkTools
	using DataFrames
	using PrettyTables
	using CSV
end

# ╔═╡ 425bfbf0-4c19-11eb-0a6e-6d5a00a82793
md"# _Bienvenue dans Pluto!_

Pluto est un environnement de programmation pour _Julia_, conçu pour être **interactif** and **pratique**. 

Dans cette introduction, nous allons parcourir les bases du langage _Julia_ en utilisant Plutothis introduction, we will go through the basics of using Pluto. Afin de rendre cela intéressant, ce notebook fait quelque chose de spécial en étant responsif: il **change  alors que vous travailler sur lui**.   

exécution d'une cellule: <shift><enter>

Computer is magic! "

# ╔═╡ 49658820-4c1f-11eb-2843-bf8462b87dba
md"
# Les manipulations de base
## Les valeurs et leur type
"

# ╔═╡ fdd145a0-4c2a-11eb-14db-8b615050cc95
3 + 5

# ╔═╡ c92a9d50-4c2b-11eb-373c-111930018fc3
typeof(7) #nombre entier stoché en 64 bits en raison de l'architecture machine

# ╔═╡ 340e7700-4c2b-11eb-2e3f-1dd734673d31
3. * 4

# ╔═╡ afd891d0-4c2c-11eb-2339-977b65f0b891
typeof(12.0)

# ╔═╡ ff32dc00-4c2b-11eb-1a07-7d364963667c
π # tapez "\pi<tab>"

# ╔═╡ 9b560530-4c2c-11eb-322a-d10903f581d1
typeof(π)

# ╔═╡ ccbbbde0-4c2c-11eb-1cd5-4f655231f04d
[1,2,3]

# ╔═╡ 84210d4e-4c2d-11eb-0f37-a7f686481c58
1+2im

# ╔═╡ 8bda4930-4c2d-11eb-2b7b-f5b58884f4ec
typeof(1+2im)

# ╔═╡ dcbcba00-4c2c-11eb-0e07-d3ed76fd7098
typeof([1,2,3])

# ╔═╡ d567e540-4c2c-11eb-2085-93c039ced357
[4. 5. 6.;7. 8. 9.]

# ╔═╡ 53242890-4c2d-11eb-3de1-b17bdf7b1721
md"
## Les variables
"

# ╔═╡ 3a714aa0-4c2b-11eb-22aa-cf44281380a7
α = 6 # variable latex-unicode  names — tapez "\alpha<tab>"

# ╔═╡ 626c1ba0-4c32-11eb-33da-3b2914157ab5
typeof(α)

# ╔═╡ 59033820-4c2b-11eb-33e1-75045e1bb19c
 β= 2α+1.5

# ╔═╡ 71551810-4c32-11eb-23d1-07a71cc94923
typeof(β)

# ╔═╡ 23dd3ef0-4c32-11eb-057d-4be03341d81b
md"
## Les vecteurs
"

# ╔═╡ 77b027b0-4c2b-11eb-1c56-9d5a448c9b72
x = [1, 17, 32, 15]  # les éléments sont séparés par des virgules

# ╔═╡ 93258ec0-4c32-11eb-3d79-691f0f9b8a3d
y = [15, 2, 6, -9]

# ╔═╡ 7bb27c70-4c33-11eb-0237-510b388f0608
x+y

# ╔═╡ 05e1817e-4c33-11eb-3980-ab1373ea590f
transpose(x)

# ╔═╡ 45acaec0-4c33-11eb-2a47-8d2e97fdc8d5
transpose(x)*y # produit scalaire

# ╔═╡ 40f89c90-4c33-11eb-353a-8755d568e83a
x .* y # produit élément par élément (broadcast)

# ╔═╡ 3fe78420-4dc7-11eb-297d-1b95a81b9d5c
pwd()

# ╔═╡ ded07220-4dc9-11eb-1ff6-ff750d15705b


# ╔═╡ 6cefc430-4dc9-11eb-2f08-b1ca17b64307
@show P = download("https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv",
    "programminglanguages1.csv")

# ╔═╡ c62fee40-4dc8-11eb-15a0-df65c45ebd16
C = CSV.File(P)

# ╔═╡ Cell order:
# ╟─425bfbf0-4c19-11eb-0a6e-6d5a00a82793
# ╟─49658820-4c1f-11eb-2843-bf8462b87dba
# ╠═fdd145a0-4c2a-11eb-14db-8b615050cc95
# ╠═c92a9d50-4c2b-11eb-373c-111930018fc3
# ╠═340e7700-4c2b-11eb-2e3f-1dd734673d31
# ╠═afd891d0-4c2c-11eb-2339-977b65f0b891
# ╠═ff32dc00-4c2b-11eb-1a07-7d364963667c
# ╠═9b560530-4c2c-11eb-322a-d10903f581d1
# ╠═ccbbbde0-4c2c-11eb-1cd5-4f655231f04d
# ╠═84210d4e-4c2d-11eb-0f37-a7f686481c58
# ╠═8bda4930-4c2d-11eb-2b7b-f5b58884f4ec
# ╠═dcbcba00-4c2c-11eb-0e07-d3ed76fd7098
# ╠═d567e540-4c2c-11eb-2085-93c039ced357
# ╟─53242890-4c2d-11eb-3de1-b17bdf7b1721
# ╠═3a714aa0-4c2b-11eb-22aa-cf44281380a7
# ╠═626c1ba0-4c32-11eb-33da-3b2914157ab5
# ╠═59033820-4c2b-11eb-33e1-75045e1bb19c
# ╠═71551810-4c32-11eb-23d1-07a71cc94923
# ╟─23dd3ef0-4c32-11eb-057d-4be03341d81b
# ╠═77b027b0-4c2b-11eb-1c56-9d5a448c9b72
# ╠═93258ec0-4c32-11eb-3d79-691f0f9b8a3d
# ╠═7bb27c70-4c33-11eb-0237-510b388f0608
# ╠═05e1817e-4c33-11eb-3980-ab1373ea590f
# ╠═45acaec0-4c33-11eb-2a47-8d2e97fdc8d5
# ╠═40f89c90-4c33-11eb-353a-8755d568e83a
# ╠═3fe78420-4dc7-11eb-297d-1b95a81b9d5c
# ╠═3f3ea480-4dc8-11eb-2ae0-effbf35a2819
# ╠═ded07220-4dc9-11eb-1ff6-ff750d15705b
# ╠═6cefc430-4dc9-11eb-2f08-b1ca17b64307
# ╠═c62fee40-4dc8-11eb-15a0-df65c45ebd16
