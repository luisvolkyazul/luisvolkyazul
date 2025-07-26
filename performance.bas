10 REM Performance Comparison
20 DIM data(999)
30 DIM result(999)
40 FOR i% = 0 TO 999
50   data(i%) = i%
60 NEXT i%
70 REM Loop-based
80 start_time% = TIME
90 FOR i% = 0 TO 999
100   result(i%) = data(i%) ^ 2 + 3 * data(i%) + 1
110 NEXT i%
120 end_time% = TIME
130 loop_time = (end_time% - start_time%) / 100
140 REM "Vectorized"
150 start_time% = TIME
160 FOR i% = 0 TO 999
170   result(i%) = data(i%) * data(i%) + 3 * data(i%) + 1
180 NEXT i%
190 end_time% = TIME
200 vector_time = (end_time% - start_time%) / 100
210 PRINT "Loop time: "; loop_time; " seconds"
220 PRINT "Vector time: "; vector_time; " seconds"
230 IF vector_time > 0 THEN
240   PRINT "Speedup: "; loop_time / vector_time; "x faster"
250 ELSE
260   PRINT "Vector time too small to calculate speedup"
270 ENDIF
280 END
