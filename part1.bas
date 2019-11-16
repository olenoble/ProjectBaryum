10 REM ###################################################
20 REM ### CAR RACE
30 screen 2: cls
40 gosub 1000: gosub 6000: maxiter = 1000: view (0,0)-(639, lr*8)
50 while (iter < maxiter) and (hascrashed = 0)
60 cls: gosub 2000
70 gosub 3000
80 gosub 5000
90 gosub 4000
100 gosub 7000
110 wend
120 view: screen 0: if hascrashed then locate 23, 10: print "YOU CRASHED!!!" else print "YOU WON!!!"
200 system

1000 REM INITIALISATION
1010 RANDOMIZE TIMER
1020 prevt = timer: ttw = 0.01: iter = 0
1020 niter = 10: newpos = 0: carpos = 40: hascrashed = 0
1040 lr = 20: wr = 8: dim walls(lr)
1050 for i = 1 to lr
1060 walls(i) = wr
1070 next i
1080 return

2000 REM DISPLAY
2010 for i = 1 to lr
2020 locate i,40+walls(i): print "#"
2030 locate i,40+walls(i)-2*wr: print "#"
2040 next i
2050 return

3000 REM MOVE FORWARD
3010 for i = lr to 2 step -1
3020 walls(i) = walls(i-1)
3030 next i
3040 if iter mod niter = 0 then newpos = int(rnd * 3) - 1
3050 walls(1) = walls(1) + int(newpos): iter = iter + 1
3060 if walls(1) >= 30 then walls(i) = 29
3070 if walls(1) <= -30+2*wr then walls(i) = -29 + 2*wr
3080 return

4000 REM TIMER
4010 dt = 1
4020 while dt
4030 if timer - prevt > ttw then dt = 0
4040 wend
4050 prevt = timer
4060 return

5000 REM CAR DISPLAY
5010 numkey = 2
5020 for k = 1 to numkey
5030 locate lr, carpos: print "W"
5040 v$ = inkey$
5050 if v$ = "a" then carpos = carpos - 1
5060 if v$ = "l" then carpos = carpos + 1
5070 locate lr, carpos: print "W"
5080 if (carpos >= walls(lr)+40) or (carpos <= walls(lr)+40-2*wr) then hascrashed = 1 else hascrashed = 0
5090 rem locate 23, 10: print hascrashed
5100 next k
5110 return

6000 REM DISTANCE BAR
6010 barlength = 75
6020 for b = 1 to barlength: locate lr+1,b: print chr$(219): next b
6030 return

7000 REM UPDATE DISTANCE BAR
7010 barfull = int(barlength /maxiter * (maxiter - iter))
7020 locate lr+1,barfull+1: print " "
7030 return

