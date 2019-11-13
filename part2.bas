10 REM ###################################################
20 REM ### MAZE
30 screen 0: cls
40 print "Generating maze...": gosub 1000
50 gosub 2000
90 print M(wm*lm)
210 system

1000 REM MAZE GENERATION
1010 wm = 79: lm = 20: complexity = 0.025: density = 0.25
1020 dim M(wm*lm)
1030 for i = 1 to lm: M((i-1)*wm) = 1: next i
1040 for i = 1 to lm: M((i-1)*wm + wm-1) = 1: next i
1050 for i = 1 to wm: M(i-1) = 1: next i
1060 for i = 1 to wm: M((lm-1)*wm + i-1) = 1: next i
1070 shapeL = int(lm / 2) * 2 + 1: shapeH = int(wm / 2) * 2 + 1
1080 comp = int(complexity * 5 * (shapeL + shapeH)): dens = int(density * int(shapeL / 2) * int(shapeH / 2))
1100 return

2000 REM DRAW MAZE
2010 for i = 1 to lm
2020 for j = 1 to wm
2030 locate i, j: if M((i-1)*wm + j-1) = 1 then print "*" else print "."
2040 next j
2050 next i
2100 return

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
