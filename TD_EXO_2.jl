using LibFEM
# Units system mm/tonne/s/K
# ===============================================================================
# 2D FRAME
# ===============================================================================
#(2)---(3)
#     / |
#    /  -
#   /   /
#  /    \
# /     -
#/      |
#(1)   (4)
# ===============================================================================
#The element used here are a linear 2D straight truss with constant cross() 
#section & a linear 2D spring.
#The degrees of freedom are the u & v displacements
# ===============================================================================
#PARAMETERS
const L=10000. #length in mm
const A=100. #cross-sectional area in mm^2
const E=210000. #modulus of elasticity in MPa [steel]
const FM=5000. #force modulus in N
const k=2100. #spring stiffness in N/mm
# ===============================================PRE-PROCESSING==================
#DEFINING AND DISCRETIZING[MESHING] THE STRUCTURE
#connectivity table
#elt||node_i||node_j
#1|1|3
#2|2|3
#3|3|4
#grid()
X1pos=0;Y1pos=0
X2pos=0;Y2pos=L
X3pos=L;Y3pos=L
X4pos=L;Y4pos=0
#lengths
L1=D2_TrussElementLength(X1pos,Y1pos,X3pos,Y3pos) #length of element 1
L2=D2_TrussElementLength(X2pos,Y2pos,X3pos,Y3pos) #length of element 2
#APPLYING GEOMETRIC&MATERIAL PROPERTIES 
A1=sqrt(2)*A #cross-sectional area of element 1
A2=A #cross-sectional area of element 2
E1=E #material of element 1
E2=E #material of element 2
#writing-defining the element stiffness matrices
K1=D2_TrussElementStiffness(E1,A1,L1,45)
println("K1=\r")
display(K1)
K2=D2_TrussElementStiffness(E2,A2,L2,0)
println("K2=\r")
display(K2)
K3=D2_SpringElementStiffness(k,-90)
println("K3=\r")
display(K3)
# ===============================================SOLVING=========================
#ASSEMBLING THE GLOBAL STIFFNESS MATRIX
#matrices initialization
K=zeros(8,8);K1P=zeros(8,8)
#positionning stiffness matrices 
K1P=D2_TrussAssemble(K,K1,1,3)
K=zeros(8,8);K2P=zeros(8,8)
K2P=D2_TrussAssemble(K,K2,2,3)
K=zeros(8,8);K3P=zeros(8,8)
K3P=D2_TrussAssemble(K,K3,3,4)
#assembling
K=K1P+K2P+K3P
println("K=\r")
display(K)
#SOLVING DISPACEMENT EQUATIONS
#extracting displacement submatrix via index vector
K_s=K[5:6,5:6]
#Setting-up the force subvector by applying Load & Boundary Conditions[LBC]]
F_s=[0 -FM]'
#solving by gaussian elimination
U_s=K_s\F_s
#SOLVING FORCE EQUATIONS
#setting-up the global nodal displacement vector
U=[0 0 0 0 U_s[1:2]' 0 0]'
#computing the global nodal force vector
F=K*U
#COMPUTING STRESSES
#writing the element nodal displacement vectors
U1=[U[1] U[2] U[5] U[6]]'
U2=[U[3] U[4] U[5] U[6]]'
#computing element strains
ϵ1=D2_TrussElementStrain(L1,45,U1)
println("ϵ1=\r")
display(ϵ1)
ϵ2=D2_TrussElementStrain(L2,0,U2)
println("ϵ2=\r")
#computing element forces
f1=D2_TrussElementForce(E1,A1,L1,45,U1)
f2=D2_TrussElementForce(E2,A2,L2,0,U2)
#computing element stresses
σ1=D2_TrussElementStress(E1,L1,45,U1)
println("σ1=\r")
display(σ1)
σ2=D2_TrussElementStress(E2,L2,0,U2)
println("σ2=\r")
display(σ2)

#= ==============================================POST-PROCESSING=================
hold on
Xini=[X1pos X3pos]
Yini=[Y1pos Y3pos]
plot(Xini,Yini,"ks-")
Xini=[X2pos X3pos]
Yini=[Y2pos Y3pos]
plot(Xini,Yini,"ks-")
fampl=100
Xdef=[(X1pos+fampl*U[1]) (X3pos+fampl*U[5])]
Ydef=[(Y1pos+fampl*U[1]) (Y3pos+fampl*U[6])]
plot(Xdef,Ydef,"bs-")
Xdef=[(X2pos+fampl*U[3]) (X3pos+fampl*U[5])]
Ydef=[(Y2pos+fampl*U[4]) (Y3pos+fampl*U[6])]
plot(Xdef,Ydef,"bs-")

=#