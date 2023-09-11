#initiate Model
using Mimi
using MimiCIAM
using Plots

#run default Model
m = MimiCIAM.get_model()
run(m)

#check results
getdataframe(m, :slrcost=>:NPVNoAdapt)
plott = Mimi.plot( m, :slrcost, :NoAdapt)
#explore(m)