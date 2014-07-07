## ExData_Plotting1 Course Project
## plot1.R: Code to produce first reference plot

## This code assumes that the downloaded zip file "household_power_consumption.zip" is in the working directory

## Read in data -- this code to be replicated in scripts for other plots

    ## Read in first two columns (date/time) as character so we can manipulate them into Date class
    dataAllDays <- read.table( unz( 'household_power_consumption.zip', filename='household_power_consumption.txt' ),
                               header=TRUE, sep=';', na.strings='?',
                               colClasses=c( rep('character', 2), rep('numeric', 7 ) ) )
    
    
    ## We're interested in only a couple of specific days' worth of data
    ## Note: date format is dd/mm/yyyy but there are no leading zeros
    ## Convert strings to Date first, then subset on the
    dataAllDays$Date <- as.Date( dataAllDays$Date, format = '%d/%m/%Y' )
    dataWorking <- subset( dataAllDays, as.character( Date ) %in% c( '2007-02-01', '2007-02-02' ) )
    
    dataWorking$DateTime <- with( dataWorking, strptime( sprintf( '%s %s', as.character( Date ), Time ),
                                                         format = '%Y-%m-%d %H:%M:%S' ) )

## 