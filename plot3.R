## ExData_Plotting1 Course Project
## plot3.R: Code to produce third reference plot

## My goal is to reproduce the visible features of the reference figure in the
## specified plot size.  Details such as exactly matching the colors of the
## reference figure, or mimicking the transparency of the backgrounds of
## figures, are beyond the scope of this assignment and course.

## This code assumes that the downloaded zip file
## "household_power_consumption.zip" is in the working directory, or that an
## rdata file containing the relevant data exists in the working directory.  The
## rdata file is created if it does not already exist.

rm( list=ls() )  ## Clean up the workspace before starting

## Read in data -- this code also appears in scripts for other plots
dataFile <- 'dataWorking.rdata'
if( dataFile %in% dir() ) {
  load( dataFile )
} else {
  ## Read in first two columns (date/time) as character so we can manipulate them into Date class
  dataAllDays <- read.table( unz( 'household_power_consumption.zip', filename='household_power_consumption.txt' ),
                             header=TRUE, sep=';', na.strings='?',
                             colClasses=c( rep('character', 2), rep('numeric', 7 ) ) )
  
  
  ## We're interested in only a couple of specific days' worth of data
  
  dataAllDays$datetime <- with( dataAllDays, strptime( sprintf( '%s %s', Date , Time ),
                                                       format = '%d/%m/%Y %H:%M:%S' ) )
  dataAllDays$Date <- with( dataAllDays, as.Date( Date, format='%d/%m/%Y' ) )
  
  dataWorking <- subset( dataAllDays, as.character( Date ) %in% c( '2007-02-01', '2007-02-02' ) )
  
  save( dataWorking, file=dataFile )

  rm( dataAllDays )
}

## 
    
png( filename = 'plot3.png' )  # Default is desired size of 480x480 pixels

  submeterColumns <- grep( 'Sub_metering', colnames( dataWorking ), value=TRUE )
  vertRange <- range( dataWorking[, submeterColumns], na.rm=TRUE )
  myColors <- c( 'black', 'red', 'blue' )

  plot( dataWorking$datetime, dataWorking[ , submeterColumns[1] ], type='n',
        xlab='',
        ylim=vertRange, ylab='Energy sub metering' )
  for( s in seq( along=submeterColumns ) ) {
    lines( dataWorking$datetime, dataWorking[ , submeterColumns[ s ] ], col=myColors[s] )
  }
  legend( 'topright', lty='solid', col=myColors, legend=submeterColumns)

  ## Normally, I would add a main title
  ## title( main='Power Consumption, Submetered by Minute, 2007-02-01 to 2007-02-02' )

dev.off()

