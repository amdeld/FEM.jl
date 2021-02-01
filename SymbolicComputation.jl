using SymPy
A = Sym[1 -1;3 4;0 2]
B = Sym[11 -11;13 14;10 12]
C = A + B
E, S, L, θ = symbols("E S L θ",real=true)
ke = E * S / L * Sym[1 0 -1 0;0 0 0 0;-1 0 1 0;0 0 0 0 ]
Re=Sym[cos(θ) sin(θ) 0 0; -sin(θ) cos(θ) 0 0; 0 0 cos(θ) sin(θ); 0 0 -sin(θ) cos(θ)]
Ke=(Re'*ke*Re)
simplify(Ke)

using ModelingToolkit
@variables E, S, L, θ
ke=E*S/L*[1 0 -1 0;0 0 0 0;-1 0 1 0;0 0 0 0 ]
Re=[cos(θ) sin(θ) 0 0;-sin(θ) cos(θ) 0 0; 0 0 cos(θ) sin(θ); 0 0 -sin(θ) cos(θ)]
Ke=Re'*ke*Re
simplify(ke)
using Latexify
latexify(Ke)