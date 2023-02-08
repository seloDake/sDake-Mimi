#Doc for initializing grossecon for multi region model
using Mimi
#=
Similar to single model with few changes
-models with regional indexes need to have those regional indexes initiated
    - some var and para need the regional index aswell as time
-setdimension for both time and region
    -same with updateparam!
-It is better to have multiple files for each component with a central file to run the model
    - this file is for component grossecon
=#


@defcomp grosseconomy begin
    #defines the gross economy component
    regions = Index()                           #regional index is defined here(can be indexed)

    #variables that index across regions need to be added into var/para indexes
    YGROSS  = Variable(index=[time, regions])   #Gross output
    K       = Variable(index=[time, regions])   #Capital
    l       = Parameter(index=[time, regions])  #Labor
    tfp     = Parameter(index=[time, regions])  #Total factor productivity
    s       = Parameter(index=[time, regions])  #Savings rate
    depk    = Parameter(index=[regions])        #Depreciation rate on capital - Note that it only has a region index
    k0      = Parameter(index=[regions])        #Initial level of capital
    share   = Parameter()                       #Capital share

    function run_timestep(p, v, d, t)
    #=
        runs through the time and region vector
        p = parameters
        v = Variables
        t = time
        d = regions
    =#
    # Note that the regional dimension is defined in d and parameters and variables are indexed by 'r'
        # Define an equation for K
        for r in d.regions
            if is_first(t)
                v.K[t,r] = p.k0[r] #base case
            else
                v.K[t,r] = (1 - p.depk[r])^5 * v.K[t-1,r] + v.YGROSS[t-1,r] * p.s[t-1,r] * 5
            end
        end

        # Define an equation for YGROSS
        for r in d.regions
            v.YGROSS[t,r] = p.tfp[t,r] * v.K[t,r]^p.share * p.l[t,r]^(1-p.share)
        end
    end
end