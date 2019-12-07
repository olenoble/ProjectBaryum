10 REM ###################################################
20 REM ### MAZE
30 screen 0: cls
40 print "PART 3 - THE FINAL BOSS"
50 locate 5, 1: print "blah, blah"
60 locate 10, 1: print "INSTRUCTIONS:": print "Oh come on... this one is easy. Just enter the column you want to play..."
70 locate 16, 1: input "READY [Y/N]"; R$
80 if (R$ = "y") or (R$ = "Y") then gosub 500 else goto 30
90 end

500 REM GAME LOOP
510 screen 2: cls
520 gosub 1000
530 iter = 0: maxiter = 10: view (0,0)-(boardstart*8, 199): haswon = 0: isfinished = 0 
540 while (iter < maxiter) and (isfinished = 0)
550 gosub 2000
570 if haswon = 0 then gosub 4000
580 rem gosub 4000  <<-- display some did you know ?!
590 rem gosub 7000
595 iter = iter + 1
600 wend
605 input "nada yet", n$: system
610 if haswon then gosub 700 else locate 6, 1: input "YOU WON!!! PRESS ENTER TO CONTINUE", E$
620 return

700 REM YOU LOSE
710 locate 6,1: input "OMG, YOU LOST!!! DO YOU WANT TO TRY AGAIN [Y/N] ?", T$
720 if (T$ = "Y") or (T$ = "y") then gothit = 0: ig = 2: jg = 1: goto 510 else system

1000 REM BOARD GENERATION
1010 boardstart = 25: bl = 10: bls = bl * 2: bh = 20: bcs = (80 - boardstart - bls) / 2 + boardstart: RANDOMIZE TIMER
1020 for i = 1 to bh: locate i, bcs: print CHR$(221): next i
1030 for i = 1 to bh: locate i, bcs + bls + 1: print CHR$(222): next i
1040 for i = 1 to bls+2: locate bh+1, bcs + i - 1: print CHR$(223): next i
1050 for i = 1 to bls step 2: locate bh+2, bcs + i: print (i - 1) / 2 + 1: next i
1060 dim BD(bl * bh): dim NP(3)
1070 return

2000 REM ASK FOR NEW X
2010 cls: locate 5, 1: input "Which Column ? ", CC
2020 if (CC < 1) or (CC > bl) then goto 2010
2030 CCI = int(CC): LASTAVAIL = BD(CCI * bh)
2040 if LASTAVAIL > 0 then locate 6, 1: input "Column already full...", W$: goto 2010
2050 i = 1
2060 while BD((CCI - 1) * bh + i) > 0: i = i + 1: wend
2070 NP(1) = CCI: NP(2) = i: NP(3) = 88: BD((NP(1) - 1) * bh + NP(2)) = 1
2080 gosub 3000
2500 return

3000 REM DROP NEW SYMBOL
3010 freq = 22.0 / 7.0: fric = 0.75: tc = 3 / fric: omega = sqr(freq * freq - fric * fric)
3020 ratio = sqr(1 + fric * fric / (omega * omega)): A = ratio * (bh - NP(2)): phi = atn(1 / (ratio * SQR(- 1 /(ratio * ratio) + 1)))
3030 ypos = bh: locate bh - ypos + 1, bcs + NP(1) * 2: print CHR$(NP(3))
3040 time0 = timer: dt = 0.01: prevt = time0: speed = 0
3050 while (speed >= 1) or (ypos - NP(2)) > 0
3060 yposnew = NP(2) + abs(sin(omega * (timer - time0) + phi) * A) * exp(-fric * (timer-time0))
3070 speed = abs(-fric * (yposnew - NP(2)) + (omega * cos(omega * (timer - time0) + phi) * A) * exp(-fric * (timer - time0)))
3080 if (timer - prevt) < dt then goto 3050 else prevt = timer
3090 locate bh - ypos + 1, bcs + NP(1) * 2: print " ": ypos = int(yposnew)
3100 locate bh - ypos + 1, bcs + NP(1) * 2: print CHR$(NP(3))
3110 wend
3500 return

4000 REM NETSKY AT WORK
4010 locate 7, 1: print "AI at work...": CC = 1 + int(rnd * bl)
4020 if (CC < 1) or (CC > bl) then goto 4010
4030 CCI = int(CC): LASTAVAIL = BD(CCI * bh)
4040 if LASTAVAIL > 0 then goto 4010
4050 i = 1
4060 while BD((CCI - 1) * bh + i) > 0: i = i + 1: wend
4070 NP(1) = CCI: NP(2) = i: NP(3) = 79: BD((NP(1) - 1) * bh + NP(2)) = 2
4080 gosub 3000
4500 return


5000 REM DATA FOR MAZE 
5010 DATA 1, 1, 1, -1, 0, 0, -1, -1, 1, 1, 1, 1, -1, 0, 0, 0, 1, 1, 1, -1, 0, 0, 0, 0, -1, 0, 1, -1, -1, 0, 0, 0


