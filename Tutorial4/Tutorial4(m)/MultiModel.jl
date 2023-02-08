#title module
module MultiModel
#Doc for creating the module for multi region model
using Mimi
#=
Similar to single model with few changes
-models with regional indexes need to have those regional indexes initiated
    - some var and para need the regional index aswell as time
-setdimension for both time and region
    -same with updateparam!
-It is better to have multiple files for each component with a central file to run the model
    - this file is to for housing the module
=#

#call docs to be used
#notation: include("document")
include("gross_econ.jl")
include("region_para.jl")
include("emissions.jl")

#export so can be used in main
export construct_MultiModel


#create function to run model by inputing the parameters/variables
function construct_MultiModel()
    #initiate model
    m = Model()

    #set dimensions for time AND regions
    set_dimension!(m, :time, collect(2015:5:2110))
	set_dimension!(m, :regions, [:Region1, :Region2, :Region3])	 # Specify regions here

    #add components to be used
    add_comp!(m, grosseconomy)
	add_comp!(m, emissions)

    #use the para file to update the paras from the component docs
    update_param!(m, :grosseconomy, :l, l)
	update_param!(m, :grosseconomy, :tfp, tfp)
	update_param!(m, :grosseconomy, :s, s)
	update_param!(m, :grosseconomy, :depk,depk)
	update_param!(m, :grosseconomy, :k0, k0)
	update_param!(m, :grosseconomy, :share, 0.3)

    update_param!(m, :emissions, :sigma, sigma)
    connect_param!(m, :emissions, :YGROSS, :grosseconomy, :YGROSS) # links the YGROSS variable from grosseconomy to the para value in emissions

    return m #model should be initiated
end

end #always close the module