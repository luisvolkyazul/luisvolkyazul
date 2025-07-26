   10           REM Temperature Conversion - Loop Approach
   20           DIM celsius_temps(5)
   30           DIM fahrenheit_temps(5)
   40           REM Initialize Celsius temperatures
   50           celsius_temps(0) = 0
   60           celsius_temps(1) = 10
   70           celsius_temps(2) = 20
   80           celsius_temps(3) = 30
   90           celsius_temps(4) = 40
  100           celsius_temps(5) = 50
  110           REM Convert to Fahrenheit using a loop
  120           FOR i% = 0 TO 5
  130             fahrenheit_temps(i%) = (celsius_temps(i%) * 9/5) + 32
  140           NEXT i%
  150           REM Print results
  160           FOR i% = 0 TO 5
  170             PRINT "Celsius temp: ";celsius_temps(i%);" in Farenheit: ";fahrenheit_temps(i%)
  180           NEXT i%
  190           END
