using Plots
x=0:0.1:1
@time plot(x,cos.(x))