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

        #Def  equation for YGROSS
        v.YGROSS[t] = p.tfp[t] * v.K[t]^p.share * p.l[t]^(1-p.share)
    end
end

@defcomp emissions begin
    #Deals with greenhouse emissions

    E	= Variable(index=[time])	# Total greenhouse gas emissions
	sigma	= Parameter(index=[time])	# Emissions output ratio
	YGROSS	= Parameter(index=[time])	# Gross output - Note that YGROSS is now a parameter

	function run_timestep(p, v, d, t)

	# Def an equation for E
	v.E[t] = p.YGROSS[t] * p.sigma[t]	# Note the p. in front of YGROSS
	end
end

# once parameers are made and set, construct model
function construct_model()
	m = Model()

	set_dimension!(m, :time, collect(2015:5:2110)) #set vector to be indexed through

	# Order matters here. If the emissions component were defined first, the model would not run.
	add_comp!(m, grosseconomy)  
	add_comp!(m, emissions) #depends on gross so should be initialized after

	# Update parameters for the grosseconomy component
	update_param!(m, :grosseconomy, :l, [(1. + 0.015)^t *6404 for t in 1:20])
	update_param!(m, :grosseconomy, :tfp, [(1 + 0.065)^t * 3.57 for t in 1:20])
	update_param!(m, :grosseconomy, :s, ones(20).* 0.22)
	update_param!(m, :grosseconomy, :depk, 0.1)
	update_param!(m, :grosseconomy, :k0, 130.)
	update_param!(m, :grosseconomy, :share, 0.3)

	# Update parameters for the emissions component
	update_param!(m, :emissions, :sigma, [(1. - 0.05)^t *0.58 for t in 1:20])
	
	# connect parameters for the emissions component
	connect_param!(m, :emissions, :YGROSS, :grosseconomy, :YGROSS)  

	return m

end #end function

m = construct_model()
run(m)

explore(m)