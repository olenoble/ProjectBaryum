10 REM RUN GAME
20 screen 0:cls
30 print "A GAME WHICH YOU ARE THE HERO"
40 print "---------------------------------------------------------------"
50 print "": print "Great news. You are a video game hero. And this is the video game which you are actually the hero of! (Coincidence ? I think not!)"
60 print "": print "Your mission, should you choose to accept it (and let's face it, you don't really have a choice), is to courageously go ahead and fight the evil NETSKY, an evil self-aware computer hell-bent on taking over the world and destroying it."
70 print"": print "Admit it, this game set-up is as good as any other 1980's game..."
80 locate 16, 1: input "ARE YOU READY FOR THIS ADVENTURE ? [Y/N]", R$
90 if (R$ = "y") or (R$ = "Y") then goto 100 else goto 20
100 load "part1.bas",r
200 screen 0: cls: print "You'd be surprised but this line of code is absolutely useless!!!!"
