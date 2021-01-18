# =============================================================================
# CALCULATRICE SCIENTIFIQUE
# =============================================================================


# opérateurs  classiques : +-*/\
1 + 3
3 / 7
3 \ 7 # ≈ 7 / 3
1e2
im # nombre complexe i
im^2
# Les fonctions usuelles : exp, log, log10, abs, sqrt, cbrt, sign
log10(100_000)
log(exp(2))
1 / (1 + exp(1))
# Les fonctions trigonométriques usuelles : sin, cos, tan, cot, sec, csc, sinh, cosh, tanh, coth, sech, csch, asin, acos, atan...
sin(pi)
cos(1 + im)

# =============================================================================
# VALEURS (tout ce qui est manipulable en Julia) & TYPES (Int32, Int64, Int128, Float32, Float64, Complex32, Complex64, Complex128...)
# =============================================================================

# types et collections

3 + 5 # nombre entier stockée en 32/64 bits en fonction de l'architecture machine
typeof(3 + 5) 
3. * 4. # nombre en virgule flottante stockée en 32/64 bits en fonction de l'architecture machine
typeof(3. * 4.)
typeof(3. * 4)
typeof(Float64)
π # tapez "\pi<tab>"
typeof(π)
Float64(π)
Float32(π)
typeof(1 + 2im)
[1,2,3]
typeof([1,2,3])
1:5 # itérateur
typeof(1:5)
collect(1:5)
0:0.1:1
typeof(0:0.1:1)
collect(0:0.1:1)
[4. 5. 6.;7. 8. 9.]
(1, 2.0, "test") # tuple
typeof((1, 2.0, "test"))
# Caractères et chaînes de caractères
'A'
"Hello" 

"racine de 2 : $(sqrt(2))"

"Hello" * " John Doe"

# Boléens et opérateurs de comparaison | "==" | "!=" | > | ">=" | "<" | "<=" | et de conjonction | "&" | "|" | "!"|

1 > 2
typeof(1 > 2)

# supertype et sous-types
supertype(Int64)
subtypes(Integer)

# type utilisateur

struct MyComplex
    _real::Float64
    _imag::Float64
end
typeof(MyComplex)
MyComplex(1,2)
typeof(MyComplex(1, 2))
# =============================================================================
# REGLE DE NOMMAGE(variables, fonctions/méthodes, modules, types, macros)
# =============================================================================

#= 
- noms des variables  en minuscule, la séparation des mots dans une variable se fait à l'aide d'un underscore ('_') ("snake case")
- noms de type et de modules commencent par une lettre majuscule, les majuscules séparant les différents mots du nom (exemple "MonModule") ("camel case")
- noms des fonctions et macros en minuscule sans underscores.
- une fonction qui modifie ses arguments s'écrit avec ! à la fin. =#

# =============================================================================
# VARIABLES (étiquettes associées aux valeurs)
# =============================================================================

# Les variables contenant des nombres scalaires

α = 6 # variable latex-unicode  names — tapez "\alpha<tab>"
typeof(α)
β = 2α + 1.5
typeof(β)
γ = α + β * im
typeof(γ)
δ = Float64(10)
δ = MyComplex(1, 2)
δ._real

# Les vecteurs (tableau de nombres scalaires ou non de dim=1)

v = [1, 17, 32, 15] 
@show v
size(v)
n = length(v)
eltype(v)
v[2] # accès à l'élément d'index n°2 (indice de départ = 1)
for i in 1:n
	println("v[$i] = $(v[i])")
end
for elt in v
	println(elt)
end
v[2:3] # slicing
v' # transposée de x
v2 = Float64[1, 2, 3, 4]
v + v2
v' * v2
sin.(v) # opérateur . de broadcast ( sin de chaque terme)
v .* v2 # opérateur . de broadcast (ici multiplication terme à terme)
v3 = ones(Int64, 3)
v4 = []
typeof(v4)
push!(v4,1)     # => [1]
push!(v4,2.)     # => [1,2.]
push!(v4,"test")     # => [1,2, "test"]
append!(v4,v4)

# Les matrices (tableau de nombres scalaires ou non dim=2 )

A = [1. 2 3
     4 5 6
     7 8 10]
ni, nj = size(A)
length(A)
eltype(A)
A[2,3]
A[end,end]
A[2,:]
A[:,2]
A[2:3,2:3]
A[1:end]
for j in 1:nj
    for i in 1:ni
        println("A[$i,$j] = $(A[i,j])")
    end
end
for elt in A
	println(elt)
end
As = similar(A)
B = fill(2.0, (3, 3))
C = A + B
C = A * B
sin.(A)
AA = [A  A] # concaténation horizontale par bloc (hcat)
AAAA = [AA;AA] # concaténation verticale par bloc (vcat)
C = [ 1 2 3; 4 5 6; 7 8 9]
C = [ u * v for u = 0:0.1:1, v = 0:0.1:1]


# =============================================================================
# Programmation 
# =============================================================================
for i = 1:5
    println("i = $i")
end
for i = 1:1000
    println(i)
    if i >= 5
       break
    end
end
i = 1
if i == 1
    println("i = 1")
end
i = 2
if i != 1
    println("i ≠ 1")
else
    println("i = 1")
end
i = 0
if i == 1
    println("i = 1")
elseif i > 1
    println("i > 1")
else 
    println("i < 1")
end
i=0
while i<5
    i+=1  # i =i+1
    println("i = $i")
end
i=0 
while i<10
    i+=1
    if i <= 5
    println("i = $i")
    else
        break
    end
end
# using LinearAlgebra

# =============================================================================
# Algèbre linéaire
# Déterminant, valeurs et vecteurs propres...
# =============================================================================

# using LinearAlgebra

A = [1. 2. 3; 4 5 6; 7 8 10.]
diag(A)
tr(A)
sum(A)
det(A)
F = eigen(A)
F.values 
F.vectors
b = [3, 2, 1] # a vector
x = A \ b # résolution du système linéaire Ax=b
xx = inv(A) * b # résolution du système linéaire Ax=b
x - xx

# =============================================================================
# Fonctions, Méthodes, Compilation, Spécialisation, Multiple Dispatch
# =============================================================================
# Version longue
function fun_name(arg1, arg2)
    tmp = arg1 + arg2
    return tmp * arg1          # <- le mot-clé return est optionnel, la dernière valeur calculée est retournée
end    
# Appel
fun_name(2, 3)

# Version courte
fun_name(arg1, arg2) = arg1 * (arg1 + arg2)
# Appel
fun_name(2, 3)

function f end
# différentes implémentations
f(x)          = println("Generic method with 1 argument : $x")
f(x::Integer) = println("Specific method with 1 argument (Integer) : $x")
f(x, y)       = println("Generic method with 2 arguments: $x, $y")
f(x::Real, y) = println("Specific method with 2 arguments (Real, Any): $x, $y")

methods(f)

f(π)
f(1)
f(im, 2)
f(π, [1, 2, 3])

@which f(im, im)

using BenchmarkTools

function my_sum(X)
    acc = zero(eltype(X)) # zero du type de l'élément de l'argument
    for x in X
        acc += x
    end
    acc
end

V = rand(1_000_000)
@time my_sum(V) # Compilation + Exécution de la fonction  my_sum avec argument de type vecteur (spécialisation)
@time my_sum(V) # Exécution de la fonction  my_sum
@time my_sum(V)

@code_native debuginfo = :none my_sum(V)

UR = (1:1_000_000)
@time my_sum(UR) # # Compilation + Exécution de la fonction  my_sum avec argument de type UnitRange (spécialisation)
@time my_sum(UR)
@time my_sum(UR)

@code_native debuginfo = :none my_sum(UR) # code natif différent du précédent  avec même implémnetation => spécialisation

@btime my_sum(UR)
@btime Base.sum(UR) # pas de magie dans Julia !!

function my_sum(X::Array{Float64,2})
    acc = zero(eltype(X))
    ni, nj = size(X)
    for j in 1:nj
        for i in 1:ni
            acc += X[i,j]
        end
    end
    acc
end
A = rand(Float64, 1_000, 1_000)
methods(my_sum)
@time my_sum(A) # type est connu, donc pas de perte de temps pour le branchement
@time my_sum(A)
@time my_sum(A)
@btime my_sum(A)
@which my_sum(A)

@code_native debuginfo = :none my_sum(A)

# =============================================================================
# Sciences des données 
# https://en.wikibooks.org/wiki/Introducing_Julia/DataFrames
# =============================================================================

using CSV
using HTTP
using DataFrames

df = CSV.File(HTTP.get("https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv").body) |> DataFrame
@show df


# =============================================================================
# Calcul parallèle sur GPU
# =============================================================================

using BenchmarkTools

mcpu = rand(2^10, 2^10)
@benchmark mcpu*mcpu

using CuArrays

mgpu = cu(mcpu)
@benchmark CuArrays.@sync mgpu*mgpu