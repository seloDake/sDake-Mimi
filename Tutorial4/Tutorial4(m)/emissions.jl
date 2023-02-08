#Doc for initializing emissions for multi region model
using Mimi
#=
Similar to single model with few changes
-models with regional indexes need to have those regional indexes initiated
    - some var and para need the regional index aswell as time
-setdimension for both time and region
    -same with updateparam!
-It is better to have multiple files for each component with a central file to run the model
    - this file is for component emissions
=#


@defcomp emissions begin #make component
    regions   = Index() #set index for regions

    #set variables
    E           = Variable(index=[time, regions])   # Total greenhouse gas emissions
    E_Global    = Variable(index=[time])            # Global emissions (sum of regional emissions)
    sigma       = Parameter(index=[time, regions])  # Emissions output ratio
    YGROSS      = Parameter(index=[time, regions])  # Gross output - Note that YGROSS is now a parameter

    function run_timestep(p, v, d, t)
     #=
        runs through the time and region vector
        p = parameters
        v = Variables
        t = time
        d = regions
    =#

    #def E equation
        for r in d.regions
            v.E[t,r] = p.YGROSS[t,r] * p.sigma[t,r]
        end

        # Define an equation for E_Global using E
        for r in d.regions
            v.E_Global[t] = sum(v.E[t,:])
        end
    end

end