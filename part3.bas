10 REM ###################################################
20 REM ### MAZE
30 screen 0: cls
40 print "PART 3 - THE FINAL BOSS"
50 locate 5, 1: print "This is it. You're now facing NETSKY, a super-powerful computer with 1Mb of RAM, 10Mb of hard-drive and two (yes, two!) 3.5' floppy disk drives!"
51 print "Not to mention the 12Mhz CPU... well this looks bad. NETSKY wants to use his super computing power and AI to challenge you a game of... CONNECT 4"
52 print "": print "What did you think it would be ? A game of tic-tac-toe ? That just always ends up in a draw!"
53 print "": print "": print "Defeat the evil computer and save the earth!"
60 locate 16, 1: print "INSTRUCTIONS:": print "You know the drill. Get 4 X in row/column/diagonal. Just enter the column you want to play..."
70 locate 20, 1: input "READY [Y/N]"; R$
80 if (R$ = "y") or (R$ = "Y") then gosub 500 else goto 30
90 goto 10000

500 REM GAME LOOP
510 screen 2: cls
520 gosub 1000
530 iter = 0: maxiter = bl * bh: view (0,0)-(boardstart*8, 199): haswon = 0: isfinished = 0 
540 while (iter < maxiter) and (isfinished = 0)
550 gosub 2000
560 if haswon = 0 then gosub 4000
570 rem gosub 6000
575 iter = iter + 1
580 wend
610 if haswon = 0 then gosub 700 else locate 23, 1: input "YOU WON!!! PRESS ENTER TO CONTINUE", E$
620 return

700 REM YOU LOSE
710 locate 23,1: input "OMG, YOU LOST!!! DO YOU WANT TO TRY AGAIN [Y/N] ?", T$
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
2090 gosub 5000
2100 return

3000 REM DROP NEW SYMBOL
3010 freq = 22.0 / 7.0 * 3: fric = 0.75 * 3: tc = 3 / fric: omega = sqr(freq * freq - fric * fric)
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
3120 return

4000 REM NETSKY AT WORK
4010 locate 7, 1: print "AI at work...": method = rnd: method2 = rnd
4020 if method <= 1 / 3.0 then CC = CCI
4030 if (method > 1 / 3.0) and (method <= 2.0 / 3.0) and (method2 <= 0.5) then CC = CCI - 1
4040 if (method > 1 / 3.0) and (method <= 2.0 / 3.0) and (method2 > 0.5) then CC = CCI + 1
4050 if (method > 2 / 3.0) then CC = 1 + int(rnd * bl)
4060 if (CC < 1) or (CC > bl) then goto 4010
4070 CCI = int(CC): LASTAVAIL = BD(CCI * bh)
4080 if LASTAVAIL > 0 then goto 4010
4090 i = 1
4100 while BD((CCI - 1) * bh + i) > 0: i = i + 1: wend
4110 NP(1) = CCI: NP(2) = i: NP(3) = 79: BD((NP(1) - 1) * bh + NP(2)) = 2
4120 gosub 3000
4130 gosub 5000
4140 return

5000 REM CHECK IF WIN
5010 if NP(3) = 88 then tocheck = 1 else tocheck = 2
5020 maxdist = 0: tempdist = 0
5030 for i = 1 to bh
5040 if BD((NP(1) - 1) * bh + i) = tocheck then tempdist = tempdist + 1 else gosub 5500
5050 next i
5060 gosub 5500
5070 for i = 1 to bl
5080 if BD((i - 1) * bh + NP(2)) = tocheck then tempdist = tempdist + 1 else gosub 5500
5090 next i
5100 gosub 5500
5110 starth = NP(1) + NP(2) - 1
5120 if starth <= bl then endi = starth else endi = bl
5130 for i = 1 to endi
5140 if BD((i - 1) * bh + starth - i + 1) = tocheck then tempdist = tempdist + 1 else gosub 5500
5150 next i
5160 gosub 5500
5170 starth = bl - NP(1) + NP(2)
5180 if starth <= bl then endi = bl + 1 - starth else endi = 1
5190 for i = bl to endi step -1
5200 if BD((i - 1) * bh + starth - (bl - i)) = tocheck then tempdist = tempdist + 1 else gosub 5500
5210 next i
5220 gosub 5500
5230 if maxdist >= 4 then isfinished = 1
5240 if (maxdist >= 4) and NP(3) = 88 then haswon = 1
5250 return

5500 REM RESET & MAX CALC
5510 maxdist = 0.5 * ((maxdist + tempdist) + abs(maxdist - tempdist))
5520 tempdist = 0
5530 return

10000 REM THIS IS THE END
10010 screen 0:cls
10020 load "epilogue.bas",r

