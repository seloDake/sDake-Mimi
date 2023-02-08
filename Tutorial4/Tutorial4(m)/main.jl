#Doc for running the module for multi region model
using Mimi
#=
Similar to single model with few changes
-models with regional indexes need to have those regional indexes initiated
    - some var and para need the regional index aswell as time
-setdimension for both time and region
    -same with updateparam!
-It is better to have multiple files for each component with a central file to run the model
    - this file is for running the module
=#

include("MultiModel.jl") #call module to be used
using .MultiModel

#run model
m = construct_MultiModel()
run(m)

#check data
getdataframe(m, :emissions, :E_Global) # m[:emissions, :E_Global] returns just the Array