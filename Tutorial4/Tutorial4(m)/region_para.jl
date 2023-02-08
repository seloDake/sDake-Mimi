#=
This file stores all the parameters for the regions
being called in the multi regional model
    -three regional model to be exact
each collumn in the array will represent diff parameter values for given regions
=#


l = Array{Float64}(undef, 20, 3) # sets the array of valus for para l
for t in 1:20 #indexed through 20 years(t = time) 
    #each line is a diff region. the notation is
    # para_name[time, region_num] = function(t)
    l[t,1] = (1. + 0.015)^t *2000 
    l[t,2] = (1. + 0.02)^t * 1250
    l[t,3] = (1. + 0.03)^t * 1700
end

tfp = Array{Float64}(undef, 20, 3)
for t in 1:20
    tfp[t,1] = (1 + 0.06)^t * 3.2
    tfp[t,2] = (1 + 0.03)^t * 1.8
    tfp[t,3] = (1 + 0.05)^t * 2.5
end

s = Array{Float64}(undef, 20, 3)
for t in 1:20
    s[t,1] = 0.21
    s[t,2] = 0.15
    s[t,3] = 0.28
end

#these are consistent over time so are filled in arrays
# from left to right region 1, 2, and 3
depk = [0.11, 0.135 ,0.15]
k0   = [50.5, 22., 33.5]

sigma = Array{Float64}(undef, 20, 3)
for t in 1:20
    sigma[t,1] = (1. - 0.05)^t * 0.58
    sigma[t,2] = (1. - 0.04)^t * 0.5
    sigma[t,3] = (1. - 0.045)^t * 0.6
end