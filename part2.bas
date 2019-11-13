10 REM ###################################################
20 REM ### MAZE
30 screen 0
40 cls: gosub 1000
50 cls: gosub 2000
90 locate 2, 1: print CHR$(210)
210 locate 23, 1: system

1000 REM MAZE GENERATION
1010 print "Generating maze:": locate 1, 20: print "[": locate 1, 31: print "]" 
1020 wm = 79: lm = 22: dim M(wm*lm): dim EM(32): steps = (wm - 3) * (lm - 2) / 10.0: sparseness = 0.75
1030 for i = 1 to lm: M((i-1)*wm) = 1: next i
1040 for i = 1 to lm: M((i-1)*wm + wm-1) = 1: next i
1050 for i = 1 to wm: M(i-1) = 1: next i
1060 for i = 1 to wm: M((lm-1)*wm + i-1) = 1: next i
1070 for i = 3 to lm - 1: M((i-1)*wm + 1) = int(rnd / sparseness): next i
1080 M(wm) = 0: counter = 1
1090 for k = 1 to 32: read EM(k): next k
1100 for i = 2 to lm - 1
1110 for j = 3 to wm - 1
1120 a = M((i-1) * wm + j - 3): b = M((i-1) * wm + j - 2)
1130 c = M((i-2) * wm + j - 2): d = M((i-2) * wm + j - 1): e = M((i-2) * wm + j)
1140 empos = int(a * 16 + b * 8 + c * 4 + d * 2 + e + 1)
1150 newval = EM(empos)
1160 if newval < 0 then if rnd < sparseness then newval = 0 else newval = 1
1170 M((i-1) * wm + j - 1) = newval
1180 if int(counter / steps) < int((counter+1)/steps) then locate 1, 20 + int((counter+1)/steps): print chr$(178)
1190 counter = counter + 1
1200 next j
1210 next i
1220 io = lm - 1: jo = wm - 1: found = 0
1230 while found = 0
1240 jo = jo - 1: if M((io - 1) * wm + jo - 1) = 0 then found = 1
1250 if jo < wm / 2 then jo = wm - 1: io = io - 1
1260 wend
1900 return

2000 REM DRAW MAZE
2010 for i = 1 to lm
2020 for j = 1 to wm
2030 locate i, j: if M((i-1)*wm + j-1) = 1 then print CHR$(219) else print " "
2040 next j
2050 next i
2060 locate io, jo: print chr$(233)
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

5000 REM DATA FOR MAZE 
5010 DATA 1, 1, 1, -1, 0, 0, -1, -1, 1, 1, 1, 1, -1, 0, 0, 0, 1, 1, 1, -1, 0, 0, 0, 0, -1, 0, 1, -1, -1, 0, 0, 0
5020 rem DATA 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0

