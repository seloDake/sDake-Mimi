#Tutorial 2 File
using Mimi
using MimiFUND


#runs FUND model
m = MimiFUND.get_model()
run(m)

# Take a lot at results
m[:socioeconomic, :income] # complete array
m[:socioeconomic, :income][100] # individual index
getdataframe(m, :socioeconomic=>:income) # dataframe requesting one variable from one component
getdataframe(m, :socioeconomic=>:income)[1:16,:]# results for regions in 950
