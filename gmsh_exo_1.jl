#  include(raw"d:\YOUR_PATH_TO\gmsh-git-Windows64-sdk\lib\gmsh.jl")
include(raw"c:\\gmsh\\lib\\gmsh.jl")

import Main.gmsh: gmsh

gmsh.initialize()

gmsh.model.add("C:\\Temp\\sphere_cut")

R = 1

R1 = 0.95

sph = gmsh.model.occ.addSphere(0, 0, 0, R, -1, 0, pi / 2, pi / 2)

b1 = gmsh.model.occ.addBox(R1, 0, 0, R, R, R)

b2 = gmsh.model.occ.addBox(0, R1, 0, R, R, R)

b3 = gmsh.model.occ.addBox(0, 0, R1, R, R, R)

gmsh.model.occ.cut([(3, sph)], [(3, b1), (3, b2), (3, b3)])
gmsh.model.occ.synchronize()
gmsh.model.removeEntities([(3, sph)])
gmsh.model.removeEntities([(2, 2), (2, 4), (2, 6)], true)
gmsh.fltk.run()
