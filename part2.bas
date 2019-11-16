10 REM ###################################################
20 REM ### MAZE
30 screen 0: cls
40 print "PART 2 - WAKA WAKA WAKA"
50 locate 5, 1: print "blah, blah"
60 locate 10, 1: print "INSTRUCTIONS:": print "J - LEFT": print "L - RIGHT": print "I - UP": print "K - DOWN"
70 locate 16, 1: input "READY [Y/N]"; R$
80 if (R$ = "y") or (R$ = "Y") then gosub 500 else goto 30
90 end

500 REM GAME LOOP
510 gothit = 0: founddoor = 0
520 gosub 1000
530 screen 2: cls: gosub 2000
540 btime = 0: stept = 0.1
550 while (founddoor = 0) and (gothit = 0)
560 gosub 3000
570 gosub 4000
580 wend
590 if gothit = 1 then gosub 700 else locate lm+2,1: input "YOU FOUND THE EXIT!!! PRESS ENTER TO CONTINUE", E$
600 return

700 REM YOU LOSE
710 locate lm+2,1: input "YOU GOT CAUGHT!!! DO YOU WANT TO TRY AGAIN [Y/N] ?", T$
720 if (T$ = "Y") or (T$ = "y") then gothit = 0: ig = 2: jg = 1: goto 530 else system

1000 REM MAZE GENERATION
1010 locate 17, 1: print "Generating maze:": locate 17, 20: print "[": locate 17, 31: print "]"
1015 rem RANDOMIZE -1977
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
1180 if int(counter / steps) < int((counter+1)/steps) then locate 17, 20 + int((counter+1)/steps): print chr$(178)
1190 counter = counter + 1
1200 next j
1210 next i
1220 io = lm - 1: jo = wm - 1: found = 0
1230 while found = 0
1240 jo = jo - 1: if M((io - 1) * wm + jo - 1) = 0 then found = 1
1250 if jo < wm / 2 then jo = wm - 1: io = io - 1
1260 wend
1270 ig = 2: jg = 1: ib = io: jb = jo: dib = -1: djb = 0: redrawdoor = 1
1280 return

2000 REM DRAW MAZE
2010 for i = 1 to lm
2020 for j = 1 to wm
2030 locate i, j: if M((i-1)*wm + j-1) = 1 then print CHR$(219) else print " "
2040 next j
2050 next i
2060 locate io, jo: print chr$(233)
2070 locate ig, jg: print CHR$(210)
2080 return

3000 REM MOVE CHARACTER
3010 hasmoved = 0: ign = ig: jgn = jg: v$ = inkey$
3020 if v$ = "j" then hasmoved = 1: jgn = jgn - 1
3030 if v$ = "l" then hasmoved = 1: jgn = jgn + 1
3040 if v$ = "i" then hasmoved = 1: ign = ign - 1
3050 if v$ = "k" then hasmoved = 1: ign = ign + 1
3060 if v$ = "q" then locate lm+1,1: input "Do you want to restart [Y/N] ?", Q$: if (Q$ = "Y") or (Q$ = "y") then goto 30
3060 if M((ign-1) * wm + jgn - 1) = 1 then hasmoved = 0
3070 if hasmoved = 1 then locate ig, jg: print " ": ig = ign: jg = jgn: locate ig, jg: print chr$(210)
3080 if (ig = io) and (jg = jo) then founddoor = 1
3090 return

4000 REM MOVE BADDY
4010 if (timer - btime) < stept then hasmoved = 0 else hasmoved = 1
4020 if hasmoved = 1 then locate ib, jb: print " ": gosub 4500: locate ib, jb: print chr$(232)
4030 if redrawdoor = 1 then locate io, jo: print chr$(233)
4040 if (io = ib) and (jo = jb) then redrawdoor = 1 else redrawdoor = 0
4050 if (ig = ib) and (jg = jb) then gothit = 1
4070 if hasmoved = 1 then btime = timer
4100 return 

4500 REM NEW POSITION
4510 validmove = 0
4520 while validmove = 0
4530 if M((ib + dib - 1) * wm + (jb + djb - 1)) = 0 then validmove = 1 else dp = rnd: dr = rnd
4540 if (validmove = 0) and (dp >= 0.5) and (dr >= 0.5) then dib = 1: djb = 0
4550 if (validmove = 0) and (dp >= 0.5) and (dr <  0.5) then dib = -1: djb = 0
4560 if (validmove = 0) and (dp <  0.5) and (dr >= 0.5) then dib = 0: djb = 1
4570 if (validmove = 0) and (dp <  0.5) and (dr <  0.5) then dib = 0: djb = -1
4580 wend
4590 ib = ib + dib: jb = jb + djb
4600 return

5000 REM DATA FOR MAZE 
5010 DATA 1, 1, 1, -1, 0, 0, -1, -1, 1, 1, 1, 1, -1, 0, 0, 0, 1, 1, 1, -1, 0, 0, 0, 0, -1, 0, 1, -1, -1, 0, 0, 0


