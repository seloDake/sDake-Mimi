#Tutorial 4 file
using Mimi
#=
How to make a model(two key steps)
-List Parameters and Variables
-use timestep function to iterate through instances
=#

@defcomp grosseconomy begin #define componenet to designed
    #=
    Try to define variables and parameters in comments
    Make Variables uppercase
    Parameters Lowercase
    if variable has a time aspect/vector: index by time
        (index = [time])
    =#
    YGROSS = Variable(index = [time])     #Gross output
    K      = Variable(index = [time])     #Capital
    l      = Parameter(index = [time])    #Labor
    tfp    = Parameter(index = [time])    #Total
    s      = Parameter(index = [time])    #Savings Rate
    depk   = Parameter()                  #Depreciation rate
    k0     = Parameter()                  #init lev of Capital
    share  = Parameter()                  #Capital share

    function run_timestep(p, v, d, t) 
        #=
        runs through the time vector
        p = parameters
        v = Variables
        t = time
        d = ???
        =#

        #def an equation for K
        if is_first(t)
            #basecase
            v.K[t] = p.k0 # v. or p. to denote type
        else
            v.K[t] = (1 - p.depk)^5 * v.K[t-1] + v.YGROSS[t-1] * p.s[t-1] * 5
        end
    end
end