# This file is for Tutorial 3
using Mimi
using MimiDICE2010
m = MimiDICE2010.get_model()
run(m)

#Go over parametric Transformations
update_param!(m, :fco22x, 3.000)# update CO2 param
run(m)

#Complex Example of Update(with regard to time)
const ts = 10
const yrs = collect(1995:ts:2505)
nyrs = length(yrs)
set_dimension!(m, :time, yrs)
run(m)

#Batch updates

explore(m)#allows for me to see plots of the results and see the changes
