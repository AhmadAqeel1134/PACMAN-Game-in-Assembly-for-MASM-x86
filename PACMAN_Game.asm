 ;Ahmad Aqeel
 ;22I-1134
 ;CS_G
 ;COAL FINAL PROJECT
 ;PACMAN Game

 



 Include Irvine32.inc
 Include macros.inc
 Includelib Winmm.lib
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD
PlaySound PROTO,
pszSound:PTR BYTE,
hmod:DWORD,
fdwSound:DWORD
.data

deviceConnect BYTE "DeviceConnect",0

SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h

file BYTE "C:\PacManTheme\1208.wav",0


  promptFirstPage BYTE "PAC_MAN",0
  colors DB 1, 2, 3, 4, 5,14 ,6,11,13,12 ; Colors: 1-Blue 2- Green,3-Cyan, 4-Red, 5-Magenta,14-Yellow ,6-Brown,11-Cyan, 13-LightMagenta, 12-LightRed      ;;;array having colors stored into it
 
 promptShowPicture1 Byte "             `````````",0
promptShowPicture2  Byte "        ____|         |____",0
promptShowPicture3  Byte "     __|                   |__",0
promptShowPicture4  Byte "  __|      ___       ___      |__",0
promptShowPicture5  Byte " |        |   |     |   |        |",0     
promptShowPicture6  Byte " |        |___|     |___|        |",0
promptShowPicture7  byte" |                               |",0
promptShowPicture8  Byte" |             ____              |",0
promptShowPicture9  byte" |            | ^^ |             |",0
promptShowPicture10 byte" |            - `` -             |",0
promptShowPicture11 byte " |       __             __       |",0
promptShowPicture12 byte " |    __|  |__       __|  |__    |",0
promptShowPicture13 byte " |___|        |  |__|        |___|",0

      promptEnterName   byte "Enter Player Name ",0 
      promptAskToSeeMenu   byte "Proceed to see Game Menu ? (Press 1) ",0
      promptEnterValid byte "Oops!!!Inavlid Choice,Try Again",0
      promptGameMenu byte " 'Game Menu' ",0
      promptLevel1 byte "'Level 1'",0
      promptLevel2 byte "'Level 2'",0
      promptLevel3 byte "'Level 3'",0
      promptInstructions byte "See Instructions ? (Press 4)",0
      promptChoice byte "Enter your choice (1-5) ",0
      tempNum byte 0
       choice DWORD 0

	  promptWin1 byte"\ \        / /  _____________                                                      -------   ____           _" ,0 
	   promptWin2 byte"\ \       / / /              \  | |        | |  \ \           ____           / /     | |     | |\ \        | |",0
       promptWin3 byte" \ \     / /  |    /'''''\    | | |        | |   \ \         / /\ \         / /      | |     | | \ \       | |",0
       promptWin4 byte"  \ \___/ /   |   |       |   | | |        | |    \ \       / /  \ \       / /       | |     | |  \ \      | |",0  
	   promptWin5 byte"   \_____/    |   |       |   | | |        | |     \ \     / /    \ \     / /        | |     | |   \ \     | |",0
	   promptWin6 byte"     | |      |   |       |   | | |        | |      \ \   / /      \ \   / /         | |     | |    \ \    | |",0
	   promptWin7 byte"     | |      |   |       |   | | |        | |       \ \ / /        \ \ / /          | |     | |     \ \   | |",0
	   promptWin8 byte"     | |      |    \,,,,,/    | | |        | |        \   /          \   /           | |     | |      \ \  | |",0
	   promptWin9 byte"     | |      |               | |  \______/  |         \ /            \ /            | |     | |       \ \ | |",0
	   promptWin10 byte"     |_|       \_____________/   \__________/                                      -------   |_|        \_\|_|",0
    
	
	
	  promptLoose1 byte" ______________      ______________     ___________    ____________     ____        " ,0 
	   promptLoose2 byte" /   _________  \   /   _________  \   |   ______  \  |   _________|   |    |                ",0
       promptLoose3 byte"|   /         \  | |   /         \  |  |   |     |  | |  |             |    |",0
       promptLoose4 byte"|  |          |  | |  |          |  |  |   \____/   | |  |             |    | ",0  
	   promptLoose5 byte"|  |          |  | |  |          |  |  |   ________/  |  |_________    |    |                    ",0
	   promptLoose6 byte"|  |          |  | |  |          |  |  |  |           |_________   |   |    |  ",0
	   promptLoose7 byte"|  |          |  | |  |          |  |  |  |                     |  |   |____|",0
	   promptLoose8 byte"|   \________/   | |   \________/   |  |  |                     |  |    ____                          ",0
	   promptLoose9 byte" \______________/   \______________/   |__|            _________|  |   |    | ",0
	  promptLoose10 byte"                                                      |____________|   |____| ",0
	
	
	
	;;;;;;;;;;;;;;Saving Name Of Player;;;;;;;;;;;;;;;
       PlayerName  DB 255 DUP(0)

       PlayerXPos db 18
       PlayerYPos db 18


	   ;;Now Declaring Variables for Positions of Enemy


	   Enemy1XPos db 35
       Enemy1YPos db 17


	   Enemy2XPos db 20
       Enemy2YPos db 17

	   
	   Enemy3XPos db 70
       Enemy3YPos db 13
       

	   Enemy4XPos db 74
       Enemy4YPos db 13

	   Enemy5XPos db 14
       Enemy5YPos db 10
       
       
       DotsXPos db 0
       DotsYPos db 0
        
        InputKey db ?
		promptMaze byte "*",0

		LevelOneArrayDL byte    2200 DUP   (90)             ;storing all the DL values of maze of Level One
		LevelOneArrayDH byte    2200 DUP   (90)             ;storing all the DH values of maze of Level One

		LevelTwoArrayDL byte    2200 DUP   (90)             ;storing all the DL values of maze of Level Two
		LevelTwoArrayDH byte    2200 DUP   (90)             ;storing all the DH values of maze of Level Two

		LevelThreeArrayDL byte    2200 DUP   (90)             ;storing all the DL values of maze of Level Three
		LevelThreeArrayDH byte    2200 DUP   (90)             ;storing all the DH values of maze of Level Three

		DotsArrayDL     byte    2200 DUP   (90)             ;storing all the DL values of dots of Level One
		DotsArrayDH     byte    2200 DUP   (90)             ;storing all the DH values of dots of Level One

		DotsArrayLevelTwoDL     byte    2200 DUP   (90)             ;storing all the DL values of dots of Level TWO
		DotsArrayLevelTwoDH     byte    2200 DUP   (90)             ;storing all the DH values of dots of Level TWO

		DotsArrayLevelThreeDL     byte    2200 DUP   (90)             ;storing all the DL values of dots of Level TWO
		DotsArrayLevelThreeDH     byte    2200 DUP   (90)             ;storing all the DH values of dots of Level TWO

		LevelTwoFoodDL          byte     7   DUP   (90)             ;storing all the DL food values of Level TWO
		LevelTwoFoodDH          byte     7   DUP   (90)             ;storing all the DH 2food values of Level TWO

	   LevelThreeFoodDL          byte     5   DUP   (90)             ;storing all the DL food values of Level TWO
		LevelThreeFoodDH          byte     5   DUP   (90)             ;storing all the DH 2food values of Level TWO

		flag byte 0       ; this variable will check whether collision occurs or not, setting it zero, initially meaning no collision
		PlayerScore DWORD 0
		LevelOneTotalDots DWORD 0
		LevelTwoTotalDots DWORD 0
		LevelThreeTotalDots DWORD 0
		DotsEaten DWORD 0

		RandomNumber db ?  ;this RandomNumber will enable us to generate random positions of Enemy!!!

		LivesAvailable db 3   ;initially three lives are available

		HiddenPathX1 db 23
		HiddenPathY1 db 9

		HiddenPathX2 db 3
		HiddenPathY2 db 27

		HiddenPathX3 db 78
		HiddenPathY3 db 28

		HiddenPathX4 db 50
		HiddenPathY4 db 22

		TeleportationPathX1 db  79
		TeleportationPathY1 db  19

		TeleportationPathX2 db   1
		TeleportationPathY2 db   19

	CountLevelThreeDots dw 0


.code
main PROC
      INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1

	 mov eax,white(black*16)
	 call setTextColor
  call FirstPage
  call Clrscr
  SecondLabel:
  call SecondPage
  call clrscr
  CMP choice,1
  JE L3
  CMP choice,4
  JE  L4
  CMP choice,2
  JE L5
  CMP choice,3
  JE L6
  JMP skip
 
    L3:
    call LevelOnePage
	call clrscr
	mov eax,white (black * 16)
	call SetTextColor
	call DisplayLose
	call crlf;
	
	call clrscr
    JMP skip
	L5:
	call LevelSecondPage
	call clrscr
	mov eax,white (black * 16)
	call SetTextColor
	call DisplayLose
	call crlf;
	call clrscr
	JMP skip
	L6:
	call LevelThreePage
	call clrscr
	mov eax,white (black * 16)
	call SetTextColor
	call DisplayLose
	call crlf;
	call clrscr
	JMP skip
   L4:
     call clrscr
    call InstructionPage
    JMP skip
 
  skip:
  mov al,15
  call setTextColor
                                         ;;;;;restarting the game
  mov LivesAvailable,3
  mov PlayerScore,0
  call waitmsg
  call clrscr
  JMP SecondLabel
 ret
  main ENDP

                                         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FirstPage Proc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FirstPage proc
 
    INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
 ;;;;;;;Here writing the name of Game ;;;;;;;;;;;;;;

   mov ecx, LENGTHOF colors   ; Loop through each color
    mov esi, OFFSET colors
    mov edi, OFFSET promptFirstPage


add esi,4
mov al,[esi]
call SetTextColor
mov dl,41
mov dh,4
call gotoxy   ;used to go towards specific location on console
mov ebx,4
mov eax,16
mov ecx,2
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptFirstPage           ;providing edx offset promptFirstPage
call writestring                         ;built in function of Irvine
mov al,15
call setTextColor
call crlf;

call crlf;

mov eax,brown
call SetTextColor
mov dl,27
mov dh,5
call gotoxy
mov edx,offset promptShowPicture1
call writestring
call crlf;

mov dl,27
mov dh,6
call gotoxy
mov edx,offset promptShowPicture2
call writestring
call crlf;
mov dl,27                    ;dl = y_axis
mov dh,7                     ;dh=x_axis
call gotoxy
mov edx,offset promptShowPicture3
call writestring
call crlf;

mov dl,27
mov dh,8
call gotoxy

mov edx,offset promptShowPicture4
call writestring
call crlf;

mov dl,27
mov dh,9
call gotoxy

mov edx,offset promptShowPicture5
call writestring
call crlf;

mov dl,27
mov dh,10
call gotoxy
mov edx,offset promptShowPicture6
call writestring
call crlf;


mov dl,27
mov dh,11
call gotoxy
mov edx,offset promptShowPicture7
call writestring
call crlf;


mov dl,27
mov dh,12
call gotoxy
mov edx,offset promptShowPicture8
call writestring
call crlf;


mov dl,27
mov dh,13
call gotoxy
mov edx,offset promptShowPicture9
call writestring
call crlf;


mov dl,27
mov dh,14
call gotoxy
mov edx,offset promptShowPicture10
call writestring
call crlf;



mov dl,27
mov dh,15
call gotoxy
mov edx,offset promptShowPicture7
call writestring
call crlf;



mov dl,27
mov dh,16
call gotoxy
mov edx,offset promptShowPicture11
call writestring
call crlf;


mov dl,27
mov dh,17
call gotoxy
mov edx,offset promptShowPicture12
call writestring
call crlf;

mov dl,27
mov dh,18
call gotoxy

mov edx,offset promptShowPicture13
call writestring
call crlf;
call crlf;
call crlf;
mov al,15
call setTextColor

call crlf;


add esi,4
mov al,[esi]
call SetTextColor          ;setting text color
mov dl,36
mov dh,20
call gotoxy
mov ebx,4
mov eax,16                 ;doing manipulation to set background
mov ecx,14
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor                   ;calling built in function of Irvine to print colourful text
mov edx,offset promptEnterName
call writestring
mov al,15
call setTextColor
call crlf;
mov dl,39
mov dh,22
call gotoxy
mov edx,offset PlayerName
mov ecx,255
call readstring


mov esi,offset colors
mov ecx,lengthof colors
add esi,6
mov al,[esi]
call SetTextColor
mov dl,39
mov dh,24
call gotoxy
mov ebx,6
mov eax,16
mov ecx,4
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset PlayerName
call writestring
;mov al,15
call setTextColor
call crlf;
call crlf;

mov esi,offset colors
mov ecx,lengthof colors
Add esi,9
mov al,[esi]
call SetTextColor
mov dl,26
mov dh,26
call gotoxy
mov ebx,13
mov eax,16
mov ecx,11
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptAskToSeeMenu
call writestring
;mov al,15
call setTextColor
call crlf;
mov dl,40
mov dh,28
call gotoxy
call readint
mov choice,eax



mov tempNum,dh

mov esi,offset colors
mov ecx,lengthof colors
Add esi,9
mov al,[esi]
call SetTextColor
InputLoop:
CMP choice,1
JE L1
mov dl,29
mov dh,tempNum
call gotoxy
mov ebx,13
mov eax,16
mov ecx,11
MUL ecx
Add eax,ebx
call setTextColor
mov edx,offset promptEnterValid
call writestring
mov al,15
call setTextColor
call crlf;
mov dh,tempNum
Add dh,4
mov dl,40
call gotoxy
call readint
mov choice,eax
mov dl,29
Add tempNum,8
mov dh,tempNum
loop InputLoop

L1:
mov al,15
call setTextColor
ret
 FirstPage endp
                                                   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                                                   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Second Page Proc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SecondPage proc

   INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1


	 ;;Upper Horizontal Border
	  call clrscr
	 mov ecx,38
	 mov dh,2
	 mov dl,26
	 mov eax,brown
	 call setTextColor
	 FirstLoop:
	 call gotoxy
	 mWrite"#"
	 inc dl
	 loop FirstLoop

	 ;;Left Vertical Line
	 mov ecx,26
	 mov dh,2
	 mov dl,26
	  mov eax,brown
	 call setTextColor
	 FirstLoop1:
	 call gotoxy
	 mWrite"#"
	 inc dh
	 loop FirstLoop1


	  ;;Right Vertical Line Vertical Line
	 mov ecx,26
	 mov dh,2
	 mov dl,64
	  mov eax,brown
	 call setTextColor
	 FirstLoop2:
	 call gotoxy
	 mWrite"#"
	 inc dh
	 loop FirstLoop2


	 ;;Bottom Horizontal Line
	 mov ecx,39
	 mov dh,28
	 mov dl,26
	  mov eax,brown
	 call setTextColor
	 FirstLoop3:
	 call gotoxy
	 mWrite"#"
	 inc dl
	 loop FirstLoop3
	 





  
 mov esi,offset colors
 mov ecx,lengthof colors
add esi,7                     ;jumping to the index of array of colors 
mov al,[esi]
call SetTextColor
mov dl,40
mov dh,4
call gotoxy
mov ebx,4
mov eax,16
mov ecx,14
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptFirstPage
call writestring
call crlf;
mov dl,37
mov dh,6
call gotoxy
mov edx,offset promptGameMenu
call writestring
call crlf;



call SetTextColor
mov dl,39
mov dh,8
call gotoxy
mov ebx,4
mov eax,16
mov ecx,14
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptLevel1
call writestring
call crlf;
mov dl,39
mov dh,10
call gotoxy
mov edx,offset promptLevel2
call writestring
call crlf;



call SetTextColor
mov dl,39
mov dh,12
call gotoxy
mov ebx,4
mov eax,16
mov ecx,14
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptLevel3
call writestring
call crlf;
mov dl,31
mov dh,14
call gotoxy
mov edx,offset promptInstructions
call writestring
call crlf;


call crlf;
mov dl,41
mov dh,16
call gotoxy
mWrite"Exit"
call crlf;


call crlf;
mov dl,33
mov dh,18
call gotoxy
mov ebx,4
mov eax,16
mov ecx,14
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptChoice
call writestring

call crlf;
mov dh,20
mov tempNum,dh

above:
mov dl,43
mov dh,tempNum
call gotoxy
call readint
mov choice,eax
CMP choice,1
JE L2
CMP choice,2
JE L2
CMP choice,3
JE L2
CMP choice,4
JE L2
CMP choice,5
JE L3
mov dl,29
add tempNum,2
mov dh,tempNum
call gotoxy
mov edx,offset promptEnterValid
call writestring
call crlf;
add tempNum,2
JMP above

L3:
mov al,15
call setTextColor

exit
L2:
mov al,15
call setTextColor
ret
SecondPage endp

                           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                           ;;;;;;;;;;;;;;;;;;;;;;;;;;;Instruction Page Proc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

InstructionPage proc

    INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
 mov esi,offset colors
add esi,10
mov al,[esi]
call SetTextColor
mov dl,40
mov dh,4
call gotoxy
mov ebx,4
mov eax,16
mov ecx,11
MUL ecx
mov ecx,0
Add eax,ebx
call setTextColor
mov edx,offset promptFirstPage
call writestring
mov dl,32
mov dh,6
call gotoxy
mWrite"Instructions To Follow ",0

call crlf;
 mov esi,offset colors
 
 add esi,2
 mov al,[esi]
 call setTextColor
mov dl,24
mov dh,8
call gotoxy
mWrite"PacMan player embarks with three lives ",0
call crlf;
 mov esi,offset colors
 
 add esi,7
 mov al,[esi]
 call setTextColor
mov dl,17
mov dh,10
call gotoxy
mWrite"Everytime player collides with enemy, he loses a life ",0
call crlf;
 mov esi,offset colors
 
 add esi,5
 mov al,[esi]
 call setTextColor
mov dl,21
mov dh,12
call gotoxy
mWrite"Eat more food,collect more dots (each of one point) to score high ",0
call crlf;
 mov esi,offset colors
 
 add esi,8
 mov al,[esi]
 call setTextColor
mov dl,20
mov dh,14
call gotoxy
mWrite"Avoid getting stuck within complex part of maze",0
call crlf;
 mov esi,offset colors

 add esi,9
 mov al,[esi]
 call setTextColor
mov dl,6
mov dh,16
call gotoxy
mWrite"The player can get extra points in each room as 'Bonus Fruit of Dark Yellow Color' appear",0
call crlf;
 mov esi,offset colors

 add esi,6
 mov al,[esi]
 call setTextColor
mov dl,24
mov dh,18
call gotoxy
mWrite"Pacman can get extra points by eating the Ghosts",0
call crlf;

mov esi,offset colors
 add esi,7
 mov al,[esi]
 call setTextColor
mov dl,33
mov dh,20
call gotoxy
mWrite"Press 'd' to move right",0
call crlf;


mov esi,offset colors
 add esi,2
 mov al,[esi]
 call setTextColor
mov dl,33
mov dh,22
call gotoxy
mWrite"Press 'a' to move left",0
call crlf;


mov esi,offset colors
add esi,3
mov al,[esi]
call setTextColor
mov dl,33
mov dh,24
call gotoxy
mWrite"Press 'w' to move up",0
call crlf


mov esi,offset colors
add esi,1
mov al,[esi]
call setTextColor
mov dl,33
mov dh,25
call gotoxy
mWrite"Press 's' to move down",0


mov esi,offset colors
add esi,2
mov al,[esi]
call setTextColor
mov dl,10
mov dh,26
call gotoxy
mWrite"Cross dark gray color to teleport and light gray color to use hidden short cuts",0



call crlf

mov al,15
call setTextColor
ret


InstructionPage endp
                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;LevelOnePage;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LevelOnePage proc

     INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
  
mov esi,offset colors
add esi,3
mov al,[esi]
call setTextColor
mov dl,41
mov dh,1
call gotoxy
mWrite"Level_1",0
call crlf
mov esi,offset colors
add esi,8
mov al,[esi]
call setTextColor
mov dl,34
mov dh,2
call gotoxy
mWrite"Player Name:",0
mov edx,offset PlayerName
call writestring
call crlf
mov esi,offset colors
add esi,7
mov al,[esi]
call setTextColor
mov dl,37
mov dh,3
call gotoxy
mWrite"Player Score  : ",0
mov eax,PlayerScore
call writedec

mov dl,36
mov dh,6
call Gotoxy
mov eax,red
call setTextColor
mWrite "Lives Available :   ",0
movzx eax,LivesAvailable
call Writedec

call crlf
mov al,15
call setTextColor

                                   
	
    ; Continue with the rest of your program

	CallingProcs:
	call PrintMazeProcedure
	call Delay
	call DrawDotsPattern
	                                      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;Counting Number of Dots;;;;;;;;;;;;;;;;;;;;;;;;
	mov ecx,lengthof DotsArrayDL
	mov esi,offset DotsArrayDL
CountingDots:
	mov al,[esi]
	CMP al,90            ;;90 is a value at which no dot is present, so we will count till untill we found the first 90 
	JE StopCounting
	inc LevelOneTotalDots
	inc esi
	loop CountingDots

	StopCounting:
	call DrawPacMan
	call Randomize
	call DrawEnemy
		



LevelOneContinue:                    ;;;;;;;;;;;;;;;;;here implementing logic for game loop of Level one;;;;;;;;;;;;;;;;;

 CMP LivesAvailable,0
 JNE skipJMP
JMP  LabelForLose

 skipJMP:
  call CheckPacmanEnemyCollision
  mov ebx,PlayerScore
  CMP ebx,LevelOneTotalDots
  JE LabelForWin                    ;all dots eaten, Player Wins Level One Ended,,,,,,hehe 
	
	   

	mov esi,offset DotsArrayDH
	mov edi,offset DotsArrayDL               
	mov ecx,Lengthof DotsArrayDL
	OuterLoop1:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos1
	tempLabel1:
     inc edi
	 inc esi
	loop OuterLoop1
    JMP DotsNotEaten
	CheckYPos1:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  increaseScore              ;food eaten and now will do increment in score
	JMP tempLabel1

	increaseScore:         ;;;removing the food indexes that have been eaten
	
	 
	mov al,-1
	mov [esi],al
	mov [edi],al
	inc PlayerScore

    DotsNotEaten:
	call RandomRange
	mov eax,white (black * 16)
	call SetTextColor
	
	    mov dl,37
        mov dh,3
		call Gotoxy
		mov eax,cyan
		call setTextColor
	    mWrite "Player Score :  ",0
	    mov eax,PlayerScore
	    call Writedec

	
		
		
		;;Calling below the functions which will check collision of each enemy separately

		call CheckEnemy1Collision  
		call CheckEnemy2Collision
		call CheckEnemy3Collision
		
	

		mov al,15
		call setTextColor

		
	mov eax,150
	call delay
	    call UpdateEnemyMovement
		call EnemyAndDot
		call GenerateRandomPositionOfEnemy
		call CheckPacManEnemyCollision
		call DrawEnemy
		call Readkey
		mov InputKey,al

		CMP inputKey,"p"
		JE PauseTheGame
	
	     ;Checking where to move PACMAN
		CMP InputKey,"w"
		JE UpwardMovement

		CMP InputKey,"s"
		JE  DownwardMovement

		CMP InputKey,"a"
		JE BackwardMovement

		CMP InputKey,"d"
	    JE  ForwardMovement    

		JMP LevelOneContinue
		UpwardMovement:
		  
			call UpdatingMovement
			dec PlayerYPos
			call DrawPacMan
			call CheckCollision
		
		
		JMP LevelOneContinue

		DownwardMovement:
		
		call UpdatingMovement
		inc PlayerYPos
		 
		call DrawPacMan
		
		call CheckCollision
		
		JMP LevelOneContinue

		BackwardMovement:
	
		call UpdatingMovement
		dec PlayerXPos	
		 
		call DrawPacMan
		
		call CheckCollision
		
		JMP LevelOneContinue

		ForwardMovement:
		; call CheckCollision
		call UpdatingMovement
		inc PlayerXPos
		 
		call DrawPacMan
		call CheckCollision
		
		JMP LevelOneContinue

	;JMP LevelOneContinue

	mov edx,0
    mov dl,0
	mov dh,0


	CheckCollision:                        ;;;;;;;;;;;;;;;;;here implementing logic to check wether pacman collides with wall or not 
	
	mov esi,offset LevelOneArrayDH
	mov edi,offset LevelOneArrayDL               
	mov ecx,2200
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
    JMP LevelOneContinue
	CheckYPos:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	JMP LevelOneContinue


	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,PlayerYPos
	mov dl,PlayerXPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	                  ;;;;;;;;;;;;;;;;;;;;;;;Here Setting Logic To Stop PacMan if Collision Occurs
	CMP InputKey,"w"
	JE Upward
	CMP InputKey,"s"
	JE Downward
	CMP InputKey,"d"
	JE Forward
	CMP InputKey,"a"
	JE Backward

	call waitmsg
	mov al,15
	call setTextColor
	
	                ;;Based on the current Axis (now as reference) where collision occurs, we go back to previous location 
	Upward:
	inc PlayerYPos
	call DrawPacMan
	JMP LevelOneContinue
	Downward:
	dec PlayerYPos
	call DrawPacMan
	JMP LevelOneContinue
	Forward:
	dec PlayerXPos
	call DrawPacMan
	JMP LevelOneContinue
	Backward:
	inc PlayerXPos
	call DrawPacMan
	JMP LevelOneContinue
	
	JMP LevelOneContinue
	                                ;;;;;;;;;;;here implementing logic to pause the game;;;;;;;;;;;
    PauseTheGame:    
   call ReadChar
   mov Inputkey,al
   CMP InputKey,"r"
   JE LevelOneContinue
   JMP PauseTheGame
   LabelForWin:
   mov eax,white(black*16)
   call setTextColor
   call DisplayWin
   call LevelSecondPage
   ret
    LabelForLose:
	mov eax,white(black*16)
   call setTextColor
   JMP exitGame
       
 

exitGame:
ret
 LevelOnePage endp

 DisplayWin proc
 INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1

 call clrscr
 mov eax,brown
 call setTextColor

 mov dh,4
 mov dl,4
 call gotoxy
 mov edx,offset promptWin1
 call writestring
 call crlf;
 mov eax,red
 call setTextColor

   mov dh,5
 mov dl,4
 call gotoxy
 mov edx,offset promptWin2
 call writestring
 call crlf;
 mov eax,blue
 call setTextColor

  mov dh,6
 mov dl,4
 call gotoxy
 mov edx,offset promptWin3
 call writestring
 call crlf;

 mov eax,green
 call setTextColor

  mov dh,7
 mov dl,4
 call gotoxy
 mov edx,offset promptWin4

 call writestring
 call crlf;

 mov eax,cyan
 call setTextColor

  mov dh,8
 mov dl,4
 call gotoxy
 mov edx,offset promptWin5
 call writestring
 call crlf;

 mov eax,magenta
 call setTextColor

  mov dh,9
 mov dl,4
 call gotoxy
 mov edx,offset promptWin6
 call writestring
 call crlf;
mov eax,LightRed
 call setTextColor

  mov dh,10
 mov dl,4
 call gotoxy
 mov edx,offset promptWin7
 call writestring
 call crlf;
 mov eax,LightMagenta
 call setTextColor

  mov dh,11
 mov dl,4
 call gotoxy
 mov edx,offset promptWin8

 call writestring
 call crlf;

 mov eax,yellow
 call setTextColor

  mov dh,12
 mov dl,4
 call gotoxy
 mov edx,offset promptWin9

 call writestring
 call crlf;
 mov eax,green
 call setTextColor

  mov dh,13
 mov dl,4
 call gotoxy
 mov edx,offset promptWin10

 call writestring
 call crlf;

 mov eax,blue
 call setTextColor
 mov dh,15
 mov dl,37
 call gotoxy
 mWrite"PlayerName : "
 mov edx,offset PlayerName
 call writestring
 call crlf;
 mov eax,red
 call setTextColor
 mov dh,17
 mov dl,39
 call gotoxy
 mWrite"You Score : "
 mov eax, PlayerScore
 call writedec

 mov eax, 1700
 call delay
 call crlf;
 mov eax,brown
 call setTextColor
 call waitMsg

ret
 DisplayWin endp

 DisplayLose proc
 mov eax,white(black*16);
 call setTextColor

  INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
 call clrscr
 mov eax,brown
 call setTextColor

 mov dh,4
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose1
 call writestring
 call crlf;
 mov eax,red
 call setTextColor

   mov dh,5
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose2
 call writestring
 call crlf;
 mov eax,blue
 call setTextColor

  mov dh,6
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose3
 call writestring
 call crlf;

 mov eax,green
 call setTextColor

  mov dh,7
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose4

 call writestring
 call crlf;

 mov eax,cyan
 call setTextColor

  mov dh,8
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose5
 call writestring
 call crlf;

 mov eax,magenta
 call setTextColor

  mov dh,9
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose6
 call writestring
 call crlf;
mov eax,LightRed
 call setTextColor

  mov dh,10
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose7
 call writestring
 call crlf;
 mov eax,LightMagenta
 call setTextColor

  mov dh,11
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose8

 call writestring
 call crlf;

 mov eax,yellow
 call setTextColor

  mov dh,12
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose9

 call writestring
 call crlf;
 mov eax,green
 call setTextColor

  mov dh,13
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose10

 call writestring
 call crlf;
  mov dh,15
 mov dl,4
 call gotoxy
 mov edx,offset promptLoose10

 
 
 mov eax,blue
 call setTextColor
 mov dh,15
 mov dl,30
 call gotoxy
 mWrite"PlayerName : "
 mov edx,offset PlayerName
 call writestring
 call crlf;
 mov eax,red
 call setTextColor
 mov dh,17
 mov dl,30
 call gotoxy
 mWrite"You Score : "
 mov eax, PlayerScore
 call writedec
  call crlf;
 mov dh,19
 mov dl,30
 call gotoxy
 mWrite"Game_Over "

 mov eax, 1700
 call delay
 call crlf;
 mov eax,brown
 call setTextColor
 mov dh,21
 mov dl,30
 call gotoxy
 call waitMsg
 
ret
 DisplayLose endp


 PrintMazeProcedure proc                                                        ;;;;;;;;;;;;;;;;;;;;;;;;;;here drawing maza for LEVEL 1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1								                                            ;;;;;;;;;;;;;;;;;My Roll No=1134, Total Walls=1+1+3+4=9;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov eax,blue
call setTextColor
     mov dl,0
	mov dh,8
	mov esi,offset LevelOneArrayDL
	mov edi,offset LevelOneArrayDH
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	mov edx,offset promptMaze
	call Delay
	call writestring
 mov ecx,80
	mov dl,0
	mov dh,8
	PrintMaze:                           ;;;;;;;;;;starting a loop to print Maze;;;;;;;;;;;;;;;
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"*"
	loop PrintMaze
	call crlf;
	
	                      ;;;;;;;;;;Printing Sides;;;;;;;;;;;
	mov dl,0
	mov dh,9
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,10
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,11
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,12
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,13
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,14
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,15
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,16
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,17
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,18
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,19
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,20
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,21
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,22
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,23
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,24
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,25
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,26
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,27
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,28
	call gotoxy
	mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"*"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi

	LowerBoundary:                                       ;;;;;;;;;;Print Lower Boundary;;;;;;;;;
	mov dl,0
	mov dh,29
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	mov edx,offset promptMaze
	call Delay
	call writestring
	mov ecx,80
	mov dl,0
	mov dh,29
	PrintLowerMaze:                                       ;starting a loop to print Maze
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"*"
	loop PrintLowerMaze

	                    ;;;;;;;;;;;;;;;;;;now drawing a basic patter inside my MAZE;;;;;;;;;;;;;;;;;;;;;;;;;;
	 
       mov eax,0
	   mov dh,12
	   mov dl,15

	   mov ecx,5
	   PrintVerticalLines:
	   call gotoxy
	   call Delay
	   mWrite"*"
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintVerticalLines
	   inc eax
	   mov dh,12
	   Add dl,15
	   mov ecx,5
	   CMP eax,4
	   JNE PrintVerticalLines

	   mov dh,20
	   mov dl,16
	   mov eax,0
	   mov ecx,8
	   PrintHorizontalLines:
	   call gotoxy
	   call Delay
	   mWrite"*"
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dl
	   loop PrintHorizontalLines
	   inc eax
	   call crlf;
	   mov dh,23
	   mov dl,16
	   mov ecx,8
	   cmp eax,2
	   JNE PrintHorizontalLines


	   mov dh,20
	   mov dl,54
	   mov eax,0
	   mov ecx,8
	   PrintHorizontalLinesAgain:
	   call gotoxy
	   call Delay
	   mWrite"*"
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dl
	   loop PrintHorizontalLinesAgain
	   inc eax
	   call crlf;
	   mov dh,23
	   mov dl,54
	   mov ecx,8
	   cmp eax,2
	   JNE PrintHorizontalLinesAgain

	   mov dh,18
	   mov dl,37
	   mov ecx,8
	   myLoop:
	   call gotoxy
	   call Delay
	   mWrite"*"
	   mov [esi],dl
	   mov[edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop myLoop

        ret

 PrintMazeProcedure endp

 DrawDotsPattern proc
 mov al,15
 call setTextColor
 mov esi,offset DotsArrayDL
 mov edi,offset DotsArrayDH
 mov dh,10
 mov dl,10
 mov ecx,60
 PrintDots:
 call gotoxy 
 call Delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc edi
 inc esi
 inc dl
 loop PrintDots

   mov ebx,0
	   mov dh,12
	   mov dl,20

	   mov ecx,5
	   PrintVerticalLines:
	   call gotoxy
	   call Delay
	   mWrite"."
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintVerticalLines
	   inc ebx
	   mov dh,12
	   Add dl,18
	   mov ecx,5
	   CMP ebx,3
	   JNE PrintVerticalLines

 mov dh,26
 mov dl,10
 mov ecx,60
 PrintDots1:
 call gotoxy 
 call Delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc edi
 inc esi
 inc dl
 loop PrintDots1

 mov ebx,0
 mov dl,7
 mov dh,11
 mov ecx,15
 PrintDots2:
 call gotoxy 
 call Delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc edi
 inc esi
 inc dh
 loop PrintDots2
 inc ebx
 mov ecx,15
 mov dh,11
 Add dl,66
 CMP ebx,2
 JNE  PrintDots2

       mov dh,21
	   mov dl,16
	   mov ebx,0
	   mov ecx,8
	   PrintHorizontalLines:
	   call gotoxy
	   call Delay
	   mWrite"."
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dl
	   loop PrintHorizontalLines
	   inc ebx
	   call crlf;
	   mov dh,21
	   Add dl,30
	   mov ecx,8
	   cmp ebx,2
	   JNE PrintHorizontalLines


 ret
 DrawDotsPattern endp
          

		  ;;;;;;;;;;;;;;;;;;;;;;Now Doing Working For Second Level;;;;;;;;;;;;;;;;;;;;;;

LevelSecondPage proc

 INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
call clrscr
mov esi,offset colors
add esi,3
mov al,[esi]
call setTextColor
mov dl,41
mov dh,1
call gotoxy
mWrite"Level_2",0
call crlf
mov esi,offset colors
add esi,8
mov al,[esi]
call setTextColor
mov dl,34
mov dh,2
call gotoxy
mWrite"Player Name:"
mov edx,offset PlayerName
call writestring
call crlf
mov esi,offset colors
add esi,7
mov al,[esi]
call setTextColor
mov dl,37
mov dh,3
call gotoxy
mWrite"Player Score  : "
mov eax,PlayerScore
call writedec
call crlf
mov esi,offset colors
add esi,6
mov al,[esi]
call setTextColor
mov dl,35
mov dh,6
call gotoxy
mWrite"Lives Available  : "
movzx eax,LivesAvailable
call writedec


call crlf
mov al,15
call setTextColor

call DrawLevelTwoMaze                  ;;;;;;;;;;;Calling Procedur for drawing a complex maze for Level Two;;;;;;;;;;;

 call DrawDotsForLevelTwo
call DrawFoodForLevelTwo

    mov ecx,lengthof DotsArrayLevelTwoDL
	mov esi,offset DotsArrayLevelTwoDL
CountingDots1:
	mov al,[esi]
	CMP al,90                 ;;90 is a value at which no dot is present, so we will count till untill we found the first 90 
	JE StopCounting
	inc LevelTwoTotalDots
	inc esi
	loop CountingDots1
	dec  LevelTwoTotalDots

	StopCounting:
	call DrawPacMan
	call DrawEnemy
	call Randomize

LevelTwoContinue:                    ;;;;;;;;;;;;;;;;;here implementing logic for game loop of Level one;;;;;;;;;;;;;;;;;
 
 CMP LivesAvailable,0
 JNE skipJMP
  JMP  LabelForLose



  skipJMP:
   call CheckPacManEnemyCollision
   mov ebx,DotsEaten       ;a temporary variable used to store count of dots eaten in level2
   CMP ebx,LevelTwoTotalDots
   JE LabelForWin               ;all dots eaten, Player Wins Level Two Ended,,,,,,HEHEHE
	
	mov esi,offset DotsArrayLevelTwoDH
	mov edi,offset DotsArrayLevelTwoDL               
	mov ecx,lengthof DotsArrayLevelTwoDH
	OuterLoop2:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos
	tempLabel2:
     inc edi
	 inc esi
	loop OuterLoop2
    JMP DotsNotEaten2
	CheckYPos:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  increaseScore2              ;food eaten and now will do increment in score
	JMP tempLabel2

	increaseScore2:         ;;;removing the food indexes that have been eaten
	mov al,-1
	mov [esi],al
	mov [edi],al
		inc PlayerScore
		inc DotsEaten

    DotsNotEaten2:
	call RandomRange
	mov eax,white (black * 16)
	call SetTextColor


	                        ;;;;;;;;Here Implementing Logic to See whether Pacman eats bonus fruits or not;;;;;;;;;;;;;;

mov esi,offset LevelTwoFoodDH
	mov edi,offset LevelTwoFoodDL               
	mov ecx,7
	OuterLoop_:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos_
	tempLabel_:
     inc edi
	 inc esi
	loop OuterLoop_
    JMP FoodNotEaten
	CheckYPos_:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  GiveBonus              ;food eaten and now will do increment in score
	JMP tempLabel_

	GiveBonus:         
	mov al,-1                 ;;;removing the food indexes that have been eaten
	mov [esi],al
	mov [edi],al
	mov eax,LightGray
	call setTextColor
      mov dl,31
      mov dh,4
      call gotoxy
	  mWrite"WhoHoo!! You Got 5 Marks Bonus"
	  mov eax,white (black*16)
	  call setTextColor
	  mov dl,31
      mov dh,4
	  call gotoxy
	  mov ecx,30
	  PrintSpace:
      call delay
	  call delay
	  call delay
	  call delay
	  call delay
	  call delay
	  mWrite" "
	  inc dl
	  loop PrintSpace
	 
   

	 
		Add PlayerScore,5
	
    FoodNotEaten:
	call RandomRange
	mov eax,white (black * 16)
	call SetTextColor



    mov esi,offset colors
    add esi,7
    mov al,[esi]
    call setTextColor
    mov dl,37
     mov dh,3
     call gotoxy
     mWrite"Player Score  : ",0
     mov eax,PlayerScore
      call writedec

	  
		mov eax,140
		call delay
		;;Following Procedures would work for Enemy and their collision with pacman
		call UpdateEnemyMovement
		call EnemyAndDot2
		call EnemyAndFruit
		call GenerateRandomPositionOfEnemy
		call CheckPacManEnemyCollision
		call DrawEnemy

		;;Checking Collision of Enemies with walls

		call Level2CheckEnemy1Collision  
		call Level2CheckEnemy2Collision
		call Level2CheckEnemy3Collision

		call ReadKey
		mov InputKey,al

		CMP inputKey,"p"
		JE PauseTheGame2
	
	     ;Checking where to move PACMAN
		CMP InputKey,"w"
		JE UpwardMovement2

		CMP InputKey,"s"
		JE  DownwardMovement2

		CMP InputKey,"a"
		JE BackwardMovement2

		CMP InputKey,"d"
	    JE  ForwardMovement2   

		JMP LevelTwoContinue

		UpwardMovement2:
			call UpdatingMovement
			dec PlayerYPos
			call DrawPacMan
			call CheckCollision2
		JMP LevelTwoContinue

		DownwardMovement2:
		; call CheckCollision
		call UpdatingMovement
		inc PlayerYPos
		call DrawPacMan
		call CheckCollision2
		JMP LevelTwoContinue

		BackwardMovement2:
		 ;call CheckCollision
		call UpdatingMovement
		dec PlayerXPos	
		call DrawPacMan
		call CheckCollision2
		JMP LevelTwoContinue

		ForwardMovement2:
		
		call UpdatingMovement
		inc PlayerXPos
		call DrawPacMan
		call CheckCollision2
		JMP LevelTwoContinue

	JMP LevelTwoContinue

	mov edx,0
    mov dl,0
	mov dh,0


	CheckCollision2:                        ;;;;;;;;;;;;;;;;;here implementing logic to check wether pacman collides with wall or not 
	
	mov esi,offset LevelTwoArrayDH
	mov edi,offset LevelTwoArrayDL               
	mov ecx,lengthof LevelTwoArrayDH
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos1
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
    JMP LevelTwoContinue
	CheckYPos1:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  CollisionDetected2               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	
	JMP LevelTwoContinue



	CollisionDetected2:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,PlayerYPos
	mov dl,PlayerXPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	                  ;;;;;;;;;;;;;;;;;;;;;;;Here Setting Logic To Stop PacMan if Collision Occurs
	CMP InputKey,"w"
	JE Upward2
	CMP InputKey,"s"
	JE Downward2
	CMP InputKey,"d"
	JE Forward2
	CMP InputKey,"a"
	JE Backward2

	call waitmsg
	mov al,15
	call setTextColor
	
	                ;;Based on the current Axis (now as reference) where collision occurs, we go back to previous location 
	Upward2:
	inc PlayerYPos
	call DrawPacMan
	JMP LevelTwoContinue
	Downward2:
	dec PlayerYPos
	call DrawPacMan
	JMP LevelTwoContinue
	Forward2:
	dec PlayerXPos
	call DrawPacMan
	JMP LevelTwoContinue
	Backward2:
	inc PlayerXPos
	call DrawPacMan
	JMP LevelTwoContinue
	
	JMP LevelTwoContinue
	                                ;;;;;;;;;;;here implementing logic to pause the game;;;;;;;;;;;
   PauseTheGame2:    
   call ReadChar
   mov Inputkey,al
   CMP InputKey,"r"
   JE LevelTwoContinue
   JMP PauseTheGame2

   LabelForWin:
   mov eax,white(black*16)
   call setTextColor
   call DisplayWin
   call LevelThreePage
   LabelForLose:
   JMP exitGame
   
exitGame:
   ret
LevelSecondPage endp

DrawPacMan proc
	mov eax,yellow (yellow*16)
	call SetTextColor
	mov dl,PlayerXPos
	mov dh,PlayerYPos
	call Gotoxy
	mov al,"&"
	call WriteChar
	ret
DrawPacMan endp

DrawEnemy proc
	mov eax,red (red*16)
	call SetTextColor
	mov dl,Enemy1XPos
	mov dh,Enemy1YPos
	call Gotoxy
	mov al,"G"
	call WriteChar

	mov eax,LightCyan (LightCyan*16)
	call SetTextColor
	mov dl,Enemy2XPos
	mov dh,Enemy2YPos
	call Gotoxy
	mov al,"G"
	call WriteChar

	mov eax,LightMagenta (LightMagenta*16)
	call SetTextColor
	mov dl,Enemy3XPos
	mov dh,Enemy3YPos
	call Gotoxy
	mov al,"G"
	call WriteChar
	ret
DrawEnemy endp

UpdatingMovement proc

mov eax,white(black*16)
call setTextColor

	mov dl,PlayerXPos
	mov dh,PlayerYPos
	call Gotoxy
	mov al," "
	call WriteChar
	ret

UpdatingMovement endp

UpdateEnemyMovement proc
mov eax,white(black*16)
call setTextColor

	mov dl,Enemy1XPos
	mov dh,Enemy1YPos
	call Gotoxy
	mov al," "
	call WriteChar

	mov dl,Enemy2XPos
	mov dh,Enemy2YPos
	call Gotoxy
	mov al," "
	call WriteChar

	mov dl,Enemy3XPos
	mov dh,Enemy3YPos
	call Gotoxy
	mov al," "
	call WriteChar
	ret
UpdateEnemyMovement endp






DrawLevelTwoMaze proc

 INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
mov eax,blue
call setTextColor
     mov dl,0
	mov dh,8
	mov esi,offset LevelTwoArrayDL
	mov edi,offset LevelTwoArrayDH
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	mWrite"#"
	call Delay
	
 mov ecx,80
	mov dl,0
	mov dh,8
	PrintMaze:                           ;;;;;;;;;;starting a loop to print Maze;;;;;;;;;;;;;;;
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"#"
	loop PrintMaze
	call crlf;
	
	                      ;;;;;;;;;;Printing Sides;;;;;;;;;;;
	mov dl,0
	mov dh,9
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,10
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,11
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,12
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,13
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,14
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
    mov dl,0
 	mov dh,15
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,16
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
     mov dl,0
	mov dh,17
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,18
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,19
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,20
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,21
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,22
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,23
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,24
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,25
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,26
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,27
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,28
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi

	LowerBoundary:                                       ;;;;;;;;;;Print Lower Boundary;;;;;;;;;
	mov dl,0
	mov dh,29
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call delay
	mWrite"#"

	mov ecx,80
	mov dl,0
	mov dh,29
	PrintLowerMaze:                                       ;starting a loop to print Maze
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"#"
	loop PrintLowerMaze

 
	                        ;;;;;;;;;;;;;;;;;Creating A Complex Pattern;;;;;;;;;;;;;;;
	mov eax,blue
	call setTextColor
	mov dh,12
	mov dl,1
	mov ecx,8
	PrintHASH1:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHASH1
	
	mov ecx,3
	mov dh,12
	PrintHASH2:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash2
	
	mov dh,10
	sub dl,4
	call gotoxy
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	mov dh,9
	call gotoxy
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi

	mov ebx,0
	mov dh,21
	mov dl,18
	mov ecx,20
	PrintHash3:
	call gotoxy
	call Delay
	mWrite "#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash3
	
	mov ebx,0
	mov dh,13
	mov dl,13
	mov ecx,8
	PrintHash:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash
	inc ebx
	mov dh,15
	mov dl,13
	mov ecx,8
	CMP ebx,2
	JNE PrintHash

		
	mov ebx,0
	mov dh,16
	mov dl,24
	mov ecx,8
	PrintHash_:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash_
	inc ebx
	mov dh,18
	mov dl,24
	mov ecx,8
	CMP ebx,2
	JNE PrintHash_	
	mov dh,22
	mov dl,26
    mov ecx,4
	PrintHash4:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash4
	
	mov ecx,12
	PrintHash5:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash5

	
	mov ecx,3
	PrintHash6:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash6

	mov ecx,5
	PrintHash7:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash7


	mov ecx,3
	PrintHash8:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash8

	mov ecx,5
	PrintHash9:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash9


	mov ecx,3
	PrintHash10:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash10

	mov ecx,5
	PrintHash11:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash11


	mov ecx,3
	PrintHash12:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash12

	mov ecx,5
	PrintHash13:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash13
	
	mov dh,15
	mov dl,73
	mov ecx,5
	PrintHash14:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash14

	mov dh,15
	mov dl,73
	mov ecx,5
	PrintHash15:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash15

	mov dl,73
	mov ecx,5
	PrintHash16:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash16


	  mov dh,10
	   mov dl,45
	   mov eax,0
	   mov ecx,8
	   PrintHash17:
	   call gotoxy
	   call Delay
	   mWrite"#"
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dl
	   loop PrintHash17
	   inc eax
	   call crlf;
	   mov dh,13
	   mov dl,45
	   mov ecx,8
	   cmp eax,2
	   JNE PrintHash17

	   mov ebx,0
	   mov dh,20
	   mov dl,65
	   mov ecx,5
	   PrintHash18:
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintHash18
	   inc ebx
	   mov dh,20
	   Add dl,6
	   mov ecx,5
	   CMP ebx,2
	   JNE PrintHash18
	  
	  mov dh,20
	   mov dl,67
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi

	   	  mov dh,20
	   mov dl,69
	    call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi

	   	mov ebx,0
	   mov dh,20
	   mov dl,4
	   mov ecx,5
	   PrintHash19:
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintHash19
	   inc ebx
	   mov dh,20
	   Add dl,6
	   mov ecx,5
	   CMP ebx,2
	   JNE PrintHash19
	   mov dh,8
	   mov dl,5
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi


ret
DrawLevelTwoMaze endp

DrawDotsForLevelTwo proc
mov al,15
call  setTextColor

mov esi,offset DotsArrayLevelTwoDL
 mov edi,offset DotsArrayLevelTwoDH

 mov dh,9
 mov dl,8
 mov ecx,70
 PrintDots1:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
 loop PrintDots1


  mov dh,11
 mov dl,12
 mov ecx,55
 PrintDots2:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
 loop PrintDots2

 Add dl,8
 mov dh,11
  mov ecx,4
 PrintDots3:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dh
 loop PrintDots3

  mov ebx,0
  mov dl,2
 mov dh,13
  mov ecx,16
 PrintDots4:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dh
 loop PrintDots4
 mov ecx,16
 inc ebx
 add dl,3
 mov dh,13
 CMP ebx,4
 JNE PrintDots4

 mov dl,1
 mov dh,28
 mov ecx,77
 PrintDots5:
 call gotoxy
 call delay
mWrite"."
mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
 loop PrintDots5

 mov dl,78
 mov dh,9
 mov ecx,20
 PrintDots6:
 call gotoxy
 call delay
mWrite"."
mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dh
 loop PrintDots6
 
 mov ebx,0
 mov dh,22
 mov dl,14
 mov ecx,10
 PrintDots7:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop PrintDots7
   mov ecx,10
   inc dh
   mov dl,14
   inc ebx
   CMP ebx,5
   JNE PrintDots7


    mov ebx,0
 mov dh,14
 mov dl,22
 mov ecx,45
 PrintDots8:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop PrintDots8
   mov ecx,45
   inc dh
   mov dl,22
   inc ebx
   CMP ebx,2
   JNE PrintDots8

     mov ebx,0
 mov dh,17
 mov dl,32
 mov ecx,45
 PrintDots9:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop PrintDots9
   mov ecx,45
   inc dh
   mov dl,32
   inc ebx
   CMP ebx,2
   JNE PrintDots9

    
 mov ebx,0
 mov dh,25
 mov dl,60
 mov ecx,16
 PrintDots10:
 call gotoxy
 call delay
 mWrite"."
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop PrintDots10
   mov ecx,16
   inc dh
   mov dl,60
   inc ebx
   CMP ebx,3
   JNE PrintDots10
 
 ret
DrawDotsForLevelTwo endp
                                  ;;;;;;;;;;;;;;Starting a procedure for generation of food at random spots;;;;;;;;;;;;;;;;;;;;;
DrawFoodForLevelTwo proc

                                     ;;;;;;;;;Here The Two Arrays (i)LevelTwoFoodDL and (ii)LevelTwoFoodDH will store location of bonus fruits;;;;;;
									 ;;;;;;;;;;;;;;;;;;;;;Eating them will give 5 marks increment in PlayerScore;;;;;;;;;;;;;;;;;;;;;;
    mov esi,offset LevelTwoFoodDL      
	mov edi,offset LevelTwoFoodDH
	mov eax,brown (brown*16)
	call SetTextColor
	mov dl,2
	mov dh,11
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,68
	mov dh,21
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,76
	mov dh,12
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,46
	mov dh,21
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,28
	mov dh,24
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,79
	mov dh,27
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov dl,17
	mov dh,14
	mov [esi],dl
	mov [edi],dh
	call Gotoxy
	mov al,"F"
	call WriteChar
	mov al,15
	call setTextColor

	ret

DrawFoodForLevelTwo endp

GenerateRandomPositionOfEnemy proc

mov eax,4
call RandomRange
inc eax
mov RandomNumber,al

CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
JMP here
M1:
dec Enemy1YPos          ; enemy will move upward
inc Enemy2YPos
dec Enemy3YPos 
JMP here
M2:
inc Enemy1YPos        ; enemy will move downward
dec Enemy2YPos
inc Enemy3YPos 
JMP here
M3:
dec Enemy1XPos           ;enemy will move backward
inc Enemy2XPos 
dec Enemy3XPos
JMP here
M4:
inc Enemy1XPos            ;enemy will move forward
dec Enemy2XPos
inc Enemy3XPos
here:
ret
GenerateRandomPositionOfEnemy endp


GenerateRandomPositionOfEnemy2 proc

mov eax,4
call RandomRange
inc eax
mov RandomNumber,al

CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
JMP here
M1:
Add Enemy1YPos,2          ; enemy will move upward
inc Enemy2YPos
dec Enemy3YPos 
JMP here
M2:
inc Enemy1YPos        ; enemy will move downward
sub Enemy2YPos,2
inc Enemy3YPos 
JMP here
M3:
dec Enemy1XPos           ;enemy will move backward
sub Enemy2XPos,2 
dec Enemy3XPos
JMP here
M4:
inc Enemy1XPos            ;enemy will move forward
add Enemy2XPos,2
inc Enemy3XPos
here:
ret
GenerateRandomPositionOfEnemy2 endp


EnemyAndDot proc

          ;;Working For First Enemy
      	mov esi,offset DotsArrayDH
	    mov edi,offset DotsArrayDL               
	      mov ecx,lengthof DotsArrayDH
	      Iteration:                                          
	      mov bl,[edi]
	      CMP bl,Enemy1XPos
	     JE CheckYPos
	     tempLabel:
          inc edi
	       inc esi
	      loop Iteration
             JMP skip
	       CheckYPos:
	         mov al,[esi]
	        CMP al,Enemy1YPos
	        JE  DrawDot              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel
			
	      DrawDot:
		  mov dh,Enemy1YPos
		  mov dl,Enemy1XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
			 skip:
			;;Working For Second Enemy
			 	mov esi,offset DotsArrayDH
	    mov edi,offset DotsArrayDL               
	      mov ecx,lengthof DotsArrayDH
	      Iteration1:                                          
	      mov bl,[edi]
	      CMP bl,Enemy2XPos
	     JE CheckYPos1
	     tempLabel1:
          inc edi
	       inc esi
	      loop Iteration1
           JMP skip1
	       CheckYPos1:
	         mov al,[esi]
	        CMP al,Enemy2YPos
	        JE  DrawDot1              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel1
		   DrawDot1:
		  mov dh,Enemy2YPos
		  mov dl,Enemy2XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
		  skip1:

		  	mov esi,offset DotsArrayDH
	    mov edi,offset DotsArrayDL               
	      mov ecx,lengthof DotsArrayDH
	      Iteration2:                                          
	      mov bl,[edi]
	      CMP bl,Enemy3XPos
	     JE CheckYPos2
	     tempLabel2:
          inc edi
	       inc esi
	      loop Iteration2
           JMP skip2
	       CheckYPos2:
	         mov al,[esi]
	        CMP al,Enemy3YPos
	        JE  DrawDot2              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel2
		   DrawDot2:
		  mov dh,Enemy3YPos
		  mov dl,Enemy3XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
          skip2:
ret
EnemyAndDot endp



EnemyAndDot2 proc

          ;;Working For First Enemy
      	mov esi,offset DotsArrayLevelTwoDH
	    mov edi,offset  DotsArrayLevelTwoDL               
	      mov ecx,lengthof  DotsArrayLevelTwoDH
	      Iteration:                                          
	      mov bl,[edi]
	      CMP bl,Enemy1XPos
	     JE CheckYPos
	     tempLabel:
          inc edi
	       inc esi
	      loop Iteration
             JMP skip
	       CheckYPos:
	         mov al,[esi]
	        CMP al,Enemy1YPos
	        JE  DrawDot              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel
			
	      DrawDot:
		  mov dh,Enemy1YPos
		  mov dl,Enemy1XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
			 skip:
			;;Working For Second Enemy
			 	mov esi,offset  DotsArrayLevelTwoDH
	    mov edi,offset  DotsArrayLevelTwoDL              
	      mov ecx,lengthof  DotsArrayLevelTwoDH
	      Iteration1:                                          
	      mov bl,[edi]
	      CMP bl,Enemy2XPos
	     JE CheckYPos1
	     tempLabel1:
          inc edi
	       inc esi
	      loop Iteration1
           JMP skip1
	       CheckYPos1:
	         mov al,[esi]
	        CMP al,Enemy2YPos
	        JE  DrawDot1              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel1
		   DrawDot1:
		  mov dh,Enemy2YPos
		  mov dl,Enemy2XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
		  skip1:

		  	mov esi,offset  DotsArrayLevelTwoDH
	    mov edi,offset  DotsArrayLevelTwoDL             
	      mov ecx,lengthof  DotsArrayLevelTwoDH
	      Iteration2:                                          
	      mov bl,[edi]
	      CMP bl,Enemy3XPos
	     JE CheckYPos2
	     tempLabel2:
          inc edi
	       inc esi
	      loop Iteration2
           JMP skip2
	       CheckYPos2:
	         mov al,[esi]
	        CMP al,Enemy3YPos
	        JE  DrawDot2              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel2
		   DrawDot2:
		  mov dh,Enemy3YPos
		  mov dl,Enemy3XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
          skip2:
ret
EnemyAndDot2 endp

CheckEnemy1Collision proc

    mov esi,offset LevelOneArrayDH
	mov edi,offset LevelOneArrayDL               
	mov ecx,lengthof LevelOneArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy1XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy1YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
     inc Enemy1YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	dec Enemy1YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
   inc Enemy1XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
 dec Enemy1XPos
    call DrawEnemy


ret
CheckEnemy1Collision endp


CheckEnemy2Collision proc

    mov esi,offset LevelOneArrayDH
	mov edi,offset LevelOneArrayDL               
	mov ecx,lengthof LevelOneArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy2XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy2YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
     dec Enemy2YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	inc Enemy2YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
     dec Enemy2XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
    inc Enemy2XPos
    call DrawEnemy


ret
CheckEnemy2Collision endp

CheckEnemy3Collision proc

    mov esi,offset LevelOneArrayDH
	mov edi,offset LevelOneArrayDL               
	mov ecx,lengthof LevelOneArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy3XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy3YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
     inc Enemy3YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
	dec Enemy3YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
     inc Enemy3XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"*"
    dec Enemy3XPos
    call DrawEnemy


ret
CheckEnemy3Collision endp


Level2CheckEnemy1Collision proc

    mov esi,offset LevelTwoArrayDH
	mov edi,offset LevelTwoArrayDL               
	mov ecx,lengthof LevelTwoArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy1XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy1YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy1YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	dec Enemy1YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
   inc Enemy1XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    dec Enemy1XPos
    call DrawEnemy


ret
Level2CheckEnemy1Collision endp


Level2CheckEnemy2Collision proc

    mov esi,offset LevelTwoArrayDH
	mov edi,offset LevelTwoArrayDL               
	mov ecx,lengthof LevelTwoArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy2XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy2YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy2YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	inc Enemy2YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy2XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    inc Enemy2XPos
    call DrawEnemy


ret
Level2CheckEnemy2Collision endp

Level2CheckEnemy3Collision proc

    mov esi,offset LevelTwoArrayDH
	mov edi,offset LevelTwoArrayDL               
	mov ecx,lengthof LevelTwoArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy3XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy3YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
     mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy3YPos
    call DrawEnemy               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	dec Enemy3YPos
    call DrawEnemy              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy3XPos
    call DrawEnemy;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    dec Enemy3XPos
    call DrawEnemy


ret
Level2CheckEnemy3Collision endp



CheckPacmanEnemyCollision proc
 mov al,PlayerXPos
mov bl,PlayerYPos

CMP al,Enemy1XPos
JE CheckYPos1
CMP al,Enemy2XPos
JE CheckYPos2
CMP al,Enemy3XPos
JE CheckYPos3
JMP skip

CheckYPos1:
CMP bl,Enemy1YPos
JE ReduceLife
JMP skip
CheckYPos2:
CMP bl,Enemy2YPos
JE ReduceLife
JMP skip
CheckYPos3:
CMP bl,Enemy3YPos
JE ReduceLife
JMP skip

ReduceLife:
dec LivesAvailable

        mov dl,36
        mov dh,6
		call Gotoxy
		mov eax,red
		call setTextColor
	    mWrite "Lives Available :   "
	    mov al,LivesAvailable
	    call Writedec

		mov dl,34
        mov dh,7
		call Gotoxy
		mov eax,LightGray
		call setTextColor
	    mWrite "Oops!Live Lost"
	     call delay
		 call delay
		 call delay
		  call delay
		mov al,15
		call setTextColor
	   mov ecx,14
	   mov dl,34
	   mov dh,7
	   Remove:
	   call gotoxy
	   call delay
	   call delay
	   call delay
	   call delay
	   call delay
	   call delay
	   mWrite" "
	   inc dl
	   loop Remove
 
 mov PlayerXPos,4
 mov PlayerYPos,16


 skip:	  
ret

CheckPacmanEnemyCollision endp

EnemyAndFruit proc                    

   ;;Working For First Enemy
      	mov esi,offset LevelTwoFoodDH
	    mov edi,offset  LevelTwoFoodDL               
	      mov ecx,lengthof  LevelTwoFoodDH
	      Iteration:                                          
	      mov bl,[edi]
	      CMP bl,Enemy1XPos
	     JE CheckYPos
	     tempLabel:
          inc edi
	       inc esi
	      loop Iteration
             JMP skip
	       CheckYPos:
	         mov al,[esi]
	        CMP al,Enemy1YPos
	        JE  DrawFruit             ;Fruit and Enemy has come on same x and y axis, so as enemy passes this location, Fruit reappears
	        JMP tempLabel
			
	      DrawFruit:
		  mov dh,Enemy1YPos
		  mov dl,Enemy1XPos
		  call gotoxy
		   mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
			 skip:
			;;Working For Second Enemy
			 	mov esi,offset LevelTwoFoodDH
	            mov edi,offset  LevelTwoFoodDL              
	      mov ecx,lengthof LevelTwoFoodDH
	      Iteration1:                                          
	      mov bl,[edi]
	      CMP bl,Enemy2XPos
	     JE CheckYPos1
	     tempLabel1:
          inc edi
	       inc esi
	      loop Iteration1
           JMP skip1
	       CheckYPos1:
	         mov al,[esi]
	        CMP al,Enemy2YPos
	        JE  DrawFruit1              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel1
		   DrawFruit1:
		  mov dh,Enemy2YPos
		  mov dl,Enemy2XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
		  skip1:

		  	mov esi,offset LevelTwoFoodDH
	    mov edi,offset  LevelTwoFoodDL             
	      mov ecx,lengthof LevelTwoFoodDH
	      Iteration2:                                          
	      mov bl,[edi]
	      CMP bl,Enemy3XPos
	     JE CheckYPos2
	     tempLabel2:
          inc edi
	       inc esi
	      loop Iteration2
           JMP skip2
	       CheckYPos2:
	         mov al,[esi]
	        CMP al,Enemy3YPos
	        JE  DrawFruit2             ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel2
		   DrawFruit2:
		  mov dh,Enemy3YPos
		  mov dl,Enemy3XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
          skip2:


	ret
EnemyAndFruit endp



LevelThreePage proc

     INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1

call clrscr
mov esi,offset colors
add esi,3
mov al,[esi]
call setTextColor
mov dl,41
mov dh,1
call gotoxy
mWrite"Level_3",0
call crlf
mov esi,offset colors
add esi,8
mov al,[esi]
call setTextColor
mov dl,34
mov dh,2
call gotoxy
mWrite"Player Name:"
mov edx,offset PlayerName
call writestring
call crlf
mov esi,offset colors
add esi,7
mov al,[esi]
call setTextColor
mov dl,37
mov dh,3
call gotoxy
mWrite"Player Score  : "
mov eax,PlayerScore
call writedec
call crlf
mov esi,offset colors
add esi,6
mov al,[esi]
call setTextColor
mov dl,35
mov dh,6
call gotoxy
mWrite"Lives Available  : "
movzx eax,LivesAvailable
call writedec


call crlf
mov al,15
call setTextColor

call DrawLevelThreeMaze                  ;;;;;;;;;;;Calling Procedur for drawing a complex maze for Level Two;;;;;;;;;;;

 call DrawDotsForLevelThree
call DrawFoodForLevelThree

  
	;mov LevelThreeTotalDots,563  ;;Total dots in Level 3 are 563

	StopCounting:
	call DrawPacMan
	call DrawEnemy2
	call DrawHiddenPaths
	call Randomize
	call DrawTeleportation
	sub CountLevelThreeDots,3

LevelThreeContinue:                    ;;;;;;;;;;;;;;;;;here implementing logic for game loop of Level one;;;;;;;;;;;;;;;;;
 
 CMP LivesAvailable,0
 JNE skipJMP
  JMP  LabelForLose



  skipJMP:
   call CheckPacManEnemyCollision
   ;mov ebx,DotsEaten       ;a temporary variable used to store count of dots eaten in level2
   CMP CountLevelThreeDots,0
   JE LabelForWin               ;all dots eaten, Player Wins Level Two Ended,,,,,,HEHEHE
	
	mov esi,offset DotsArrayLevelThreeDH
	mov edi,offset DotsArrayLevelThreeDL               
	mov ecx,lengthof DotsArrayLevelThreeDH
	OuterLoop2:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos
	tempLabel2:
     inc edi
	 inc esi
	loop OuterLoop2
    JMP DotsNotEaten2
	CheckYPos:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  increaseScore2              ;food eaten and now will do increment in score
	JMP tempLabel2

	increaseScore2:         ;;;removing the food indexes that have been eaten
	mov al,-1
	mov [esi],al
	mov [edi],al
		inc PlayerScore
		dec CountLevelThreeDots

    DotsNotEaten2:
	call RandomRange
	mov eax,white (black * 16)
	call SetTextColor

	  
	  ;;;;;;;;;;;;;;Here Implementing Logic For Moving Along HiddenPaths;;;;;;;;;;;;
	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,HiddenPathX1
	JNE CheckNextPath
	CMP bl,HiddenPathY1
	JNE CheckNextPath
	call UpdatingMovement
	mov PlayerXPos,51
	mov PlayerYPos,22
	call DrawPacman

	CheckNextPath:
	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,HiddenPathX2
	JNE CheckNextPath1
	CMP bl,HiddenPathY2
	JNE CheckNextPath1
	call UpdatingMovement
	mov PlayerXPos,77
	mov PlayerYPos,28
	call DrawPacman
	
	CheckNextPath1:
	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,HiddenPathX3
	JNE CheckNextPath2
	CMP bl,HiddenPathY3
	JNE CheckNextPath2
	call UpdatingMovement
	mov PlayerXPos,2
	mov PlayerYPos,28
	call DrawPacman
	
	CheckNextPath2:

	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,HiddenPathX4
	JNE skip_
	CMP bl,HiddenPathY4
	JNE skip_
	call UpdatingMovement
	mov PlayerXPos,26
	mov PlayerYPos,9
	call DrawPacman

	skip_:
	
	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport
	call UpdatingMovement
	mov PlayerXPos,2
	mov PlayerYPos,19
	call DrawPacman

	CheckNextTeleport:
	mov al,PlayerXPos
	mov bl,PlayerYPos
	CMP al,TeleportationPathX2
	JNE skip__
	CMP bl,TeleportationPathY2
	JNE skip__
	call UpdatingMovement
	mov PlayerXPos,78
	mov PlayerYPos,19
	call DrawPacman

	skip__:
	call EnemyAndTeleportationPath

	                        ;;;;;;;;Here Implementing Logic to See whether Pacman eats bonus fruits or not;;;;;;;;;;;;;;

    mov esi,offset LevelThreeFoodDH
	mov edi,offset LevelThreeFoodDL               
	mov ecx,lengthof LevelThreeFoodDL
	OuterLoop_:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos_
	tempLabel_:
     inc edi
	 inc esi
	loop OuterLoop_
    JMP FoodNotEaten
	CheckYPos_:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  GiveBonus              ;food eaten and now will do increment in score
	JMP tempLabel_

	GiveBonus:         
	mov al,-1                 ;;;removing the food indexes that have been eaten
	mov [esi],al
	mov [edi],al
	mov eax,LightGray
	call setTextColor
      mov dl,31
      mov dh,4
      call gotoxy
	  mWrite"WhoHoo!! You Got 5 Marks Bonus"
	  mov eax,white (black*16)
	  call setTextColor
	  mov dl,31
      mov dh,4
	  call gotoxy
	  mov ecx,30
	  PrintSpace:
      call delay
	  call delay
	  call delay
	  call delay
	  call delay
	  call delay
	  mWrite" "
	  inc dl
	  loop PrintSpace
	 
	Add PlayerScore,5
	
    FoodNotEaten:
	call RandomRange
	mov eax,white (black * 16)
	call SetTextColor



    mov esi,offset colors
    add esi,7
    mov al,[esi]
    call setTextColor
    mov dl,37
     mov dh,3
     call gotoxy
     mWrite"Player Score  : ",0
     mov eax,PlayerScore
      call writedec

	  
		mov eax,100
		call delay
		;;Following Procedures would work for Enemy and their collision with pacman
		call UpdateEnemyMovement2
		call EnemyAndDot3
		call EnemyAndFruit3
		call DrawHiddenPaths
		call DrawTeleportation
		call GenerateRandomPositionOfEnemy3
		call CheckPacManEnemyCollision3
		call DrawEnemy2

		;;Checking Collision of Enemies with walls

		call Level3CheckEnemy1Collision  
		call Level3CheckEnemy2Collision
		call Level3CheckEnemy3Collision
		call Level3CheckEnemy4Collision
		call Level3CheckEnemy5Collision
		  
		call ReadKey
		mov InputKey,al

		CMP inputKey,"p"
		JE PauseTheGame2
	
	     ;Checking where to move PACMAN
		CMP InputKey,"w"
		JE UpwardMovement2

		CMP InputKey,"s"
		JE  DownwardMovement2

		CMP InputKey,"a"
		JE BackwardMovement2

		CMP InputKey,"d"
	    JE  ForwardMovement2   

		JMP LevelThreeContinue

		UpwardMovement2:
			call UpdatingMovement
			dec PlayerYPos
			call DrawPacMan
			call CheckCollision2
		JMP LevelThreeContinue

		DownwardMovement2:
	
		call UpdatingMovement
		inc PlayerYPos
		call DrawPacMan
		call CheckCollision2
		JMP LevelThreeContinue

		BackwardMovement2:
		
		call UpdatingMovement
		dec PlayerXPos	
		call DrawPacMan
		call CheckCollision2
		JMP LevelThreeContinue

		ForwardMovement2:
		
		call UpdatingMovement
		inc PlayerXPos
		call DrawPacMan
		call CheckCollision2
		JMP LevelThreeContinue

	JMP LevelThreeContinue

	mov edx,0
    mov dl,0
	mov dh,0


	CheckCollision2:                        ;;;;;;;;;;;;;;;;;here implementing logic to check wether pacman collides with wall or not 
	
	mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDH
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,PlayerXPos
	JE CheckYPos1
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
    JMP LevelThreeContinue
	CheckYPos1:
	mov al,[esi]
	CMP al,PlayerYPos
	JE  CollisionDetected2               ;collisionDetected    (Player Collides at x-axis (PlayerXPos) and y-axis (PLayerYPos) )
	JMP tempLabel
	
	JMP LevelThreeContinue



	CollisionDetected2:       ;;;;;This label works when PACMAN collides with walls ;;;;;;;
	mov dh,PlayerYPos
	mov dl,PlayerXPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	                  ;;;;;;;;;;;;;;;;;;;;;;;Here Setting Logic To Stop PacMan if Collision Occurs
	CMP InputKey,"w"
	JE Upward2
	CMP InputKey,"s"
	JE Downward2
	CMP InputKey,"d"
	JE Forward2
	CMP InputKey,"a"
	JE Backward2

	call waitmsg
	mov al,15
	call setTextColor
	
	                ;;Based on the current Axis (now as reference) where collision occurs, we go back to previous location 
	Upward2:
	inc PlayerYPos
	call DrawPacMan
	JMP LevelThreeContinue
	Downward2:
	dec PlayerYPos
	call DrawPacMan
	JMP LevelThreeContinue
	Forward2:
	dec PlayerXPos
	call DrawPacMan
	JMP LevelThreeContinue
	Backward2:
	inc PlayerXPos
	call DrawPacMan
	JMP LevelThreeContinue
	
	JMP LevelThreeContinue
	                                ;;;;;;;;;;;here implementing logic to pause the game;;;;;;;;;;;
   PauseTheGame2:    
   call ReadChar
   mov Inputkey,al
   CMP InputKey,"r"
   JE LevelThreeContinue
   JMP PauseTheGame2

   LabelForWin:
   mov eax,white(black*16)
   call setTextColor
   call DisplayEnd
   call SecondPage
   LabelForLose:
   mov eax,white(black*16)
   call setTextColor
   JMP exitGame
   
exitGame:
   ret
   

LevelThreePage endp


DrawLevelThreeMaze proc
     INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
     INVOKE PlaySound, OFFSET file, NULL, 1
mov eax,blue
call setTextColor
     mov dl,0
	mov dh,8
	mov esi,offset LevelThreeArrayDL
	mov edi,offset LevelThreeArrayDH
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	mWrite"#"
	call Delay
	
 mov ecx,80
	mov dl,0
	mov dh,8
	PrintMaze:                           ;;;;;;;;;;starting a loop to print Maze;;;;;;;;;;;;;;;
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"#"
	loop PrintMaze
	call crlf;
	
	                      ;;;;;;;;;;Printing Sides;;;;;;;;;;;
	mov dl,0
	mov dh,9
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,10
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,11
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,12
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,13
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,14
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,15
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,16
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
mov dl,0
	mov dh,17
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	mov dh,18
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,19
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,20
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,21
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,22
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,23
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,24
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,25
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,26
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,27
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 	mov dl,0
	 mov dh,28
	call gotoxy
	mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi
	 mov dl,80
	 call gotoxy
	 mWrite"#"
	 mov [esi],dl
	 mov [edi],dh
	 inc esi
	 inc edi

	LowerBoundary:                                       ;;;;;;;;;;Print Lower Boundary;;;;;;;;;
	mov dl,0
	mov dh,29
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call delay
	mWrite"#"

	mov ecx,80
	mov dl,0
	mov dh,29
	PrintLowerMaze:                                       ;starting a loop to print Maze
	inc dl
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call gotoxy
	call Delay
	mWrite"#"
	loop PrintLowerMaze

 
	                        ;;;;;;;;;;;;;;;;;Creating A Complex Pattern;;;;;;;;;;;;;;;
	mov eax,blue
	call setTextColor
	mov dh,12
	mov dl,1
	mov ecx,8
	PrintHASH1:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHASH1
	
	mov ecx,3
	mov dh,12
	PrintHASH2:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash2
	
	mov dh,10
	sub dl,4
	call gotoxy
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	mov dh,9
	call gotoxy
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi

	mov ebx,0
	mov dh,21
	mov dl,18
	mov ecx,20
	PrintHash3:
	call gotoxy
	call Delay
	mWrite "#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash3
	
	mov ebx,0
	mov dh,13
	mov dl,13
	mov ecx,8
	PrintHash:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash
	inc ebx
	mov dh,15
	mov dl,13
	mov ecx,8
	CMP ebx,2
	JNE PrintHash

		
	mov ebx,0
	mov dh,16
	mov dl,24
	mov ecx,8
	PrintHash_:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash_
	inc ebx
	mov dh,18
	mov dl,24
	mov ecx,8
	CMP ebx,2
	JNE PrintHash_	
	mov dh,22
	mov dl,26
    mov ecx,4
	PrintHash4:
	call gotoxy
	call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash4
	
	mov ecx,12
	PrintHash5:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash5

	
	mov ecx,3
	PrintHash6:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash6

	mov ecx,5
	PrintHash7:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash7


	mov ecx,3
	PrintHash8:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash8

	mov ecx,5
	PrintHash9:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash9


	mov ecx,3
	PrintHash10:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash10

	mov ecx,5
	PrintHash11:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash11


	mov ecx,3
	PrintHash12:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dh
	loop PrintHash12

	mov ecx,5
	PrintHash13:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash13
	
	mov dh,15
	mov dl,73
	mov ecx,5
	PrintHash14:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash14

	mov dh,15
	mov dl,73
	mov ecx,5
	PrintHash15:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	dec dh
	loop PrintHash15

	mov dl,73
	mov ecx,5
	PrintHash16:
		call gotoxy
		call delay
	mWrite"#"
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	inc dl
	loop PrintHash16


	  mov dh,10
	   mov dl,45
	   mov eax,0
	   mov ecx,8
	   PrintHash17:
	   call gotoxy
	   call Delay
	   mWrite"#"
	   mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dl
	   loop PrintHash17
	   inc eax
	   call crlf;
	   mov dh,13
	   mov dl,45
	   mov ecx,8
	   cmp eax,2
	   JNE PrintHash17

	   mov ebx,0
	   mov dh,20
	   mov dl,65
	   mov ecx,5
	   PrintHash18:
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintHash18
	   inc ebx
	   mov dh,20
	   Add dl,6
	   mov ecx,5
	   CMP ebx,2
	   JNE PrintHash18
	  
	  mov dh,20
	   mov dl,67
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi

	   	  mov dh,20
	   mov dl,69
	    call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi

	   	mov ebx,0
	   mov dh,20
	   mov dl,4
	   mov ecx,5
	   PrintHash19:
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi
	   inc dh
	   loop PrintHash19
	   inc ebx
	   mov dh,20
	   Add dl,6
	   mov ecx,5
	   CMP ebx,2
	   JNE PrintHash19
	   mov dh,8
	   mov dl,5
	   call gotoxy
	   call delay
	   mWrite"#"
	    mov [esi],dl
	   mov [edi],dh
	   inc esi
	   inc edi

	   mov al,60
	   mov ebx,3
	 mov ecx,5
	 mov dh,8
	 mov dl,60
	 MakePattern1:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dh
	 loop MakePattern1
	 dec ebx
	 mov dh,8
	 add al,4
	 mov dl,al
	 mov ecx,5
	 cmp ebx,0
	 JNE MakePattern1

	 mov dh,12
	 mov dl,62
	 call gotoxy
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi

	  mov dh,12
	 mov dl,66
	 call gotoxy
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi

	 
	  
	 mov ebx,2
	 mov ecx,4
	 mov dh,21
	 mov dl,30
	 MakePattern2:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dh
	 loop MakePattern2
	 dec ebx
	 mov dh,21
	 Add dl,3
	 mov ecx,4
	 cmp ebx,0
	 JNE MakePattern2

	 mov dh,26
	 mov dl,1
	 mov ecx,6
	 MakePattern3:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dl
	 loop MakePattern3

	 mov dh,26
	 mov ecx,3
	 MakePattern4:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dh
	 loop MakePattern4

	 mov ebx,2
	 mov ecx,5
	 mov dh,25
	 mov dl,75
	 MakePattern5:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dl
	 loop MakePattern5
	 dec ebx
	 mov ecx,5
	 Add dh,2
	 mov dl,75
	 cmp ebx,0
	 JNE MakePattern5

	
	 mov dh,11
	 mov dl,23
	  mov ecx,10
	 MakePattern6:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dl
	 loop MakePattern6

	  mov dh,9
	 mov dl,33
	  mov ecx,3
	 MakePattern7:
	 call gotoxy
	 call delay
	 mWrite"#"
	 mov[esi],dl
	 mov[edi],dh
	 inc edi
	 inc esi
	 inc dh
	 loop MakePattern7
	 

ret
DrawLevelThreeMaze endp


DrawDotsForLevelThree proc
mov al,15
 call setTextColor
 mov esi,offset DotsArrayLevelThreeDL
 mov edi,offset DotsArrayLevelThreeDH

 mov ebx,4
 mov dh,13
 mov dl,3
 mov ecx,13
 MakeDots1:
 call gotoxy
 mWrite"."
 inc CountLevelThreeDots
 inc dh
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
loop MakeDots1
dec ebx
mov dh,13
Add dl,2
mov ecx,13
CMP ebx,0
JNE MakeDots1

  
  mov ebx,0
 mov dh,22
 mov dl,14
 mov ecx,10
 MakeDots2:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop MakeDots2
   mov ecx,10
   inc dh
   mov dl,14
   inc ebx
   CMP ebx,5
   JNE MakeDots2

      mov dh,27
   mov dl,9
   mov ecx,65
   MakeDots3:
   call gotoxy
   mWrite"."
    inc CountLevelThreeDots
   inc dl
   mov [esi],dl
   mov [edi],dh
   inc esi
   inc edi
   loop MakeDots3
  

  mov ebx,0
  mov dh,14
 mov dl,22
 mov ecx,48
 MakeDots4:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop MakeDots4
   mov ecx,48
   inc dh
   mov dl,22
   inc ebx
   CMP ebx,2
   JNE MakeDots4


  mov dh,9
 mov dl,35
 mov ecx,24
 MakeDots5:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop MakeDots5



mov ebx,0
 mov dh,16
 mov dl,33
 mov ecx,43
 MakeDots6:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop MakeDots6
   mov ecx,43
   inc dh
   mov dl,33
   inc ebx
   CMP ebx,4
   JNE MakeDots6


   mov dh,9
mov dl,78
mov ecx,16
MakeDots7:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dh
 loop MakeDots7

  

    mov ebx,0
 mov dh,24
 mov dl,40
 mov ecx,13
 MakeDots8:
 call gotoxy
 call delay
 mWrite"."
 inc CountLevelThreeDots
 mov [esi],dl
 mov [edi],dh
 inc esi
 inc edi
 inc dl
loop MakeDots8
   mov ecx,13
   inc dh
   mov dl,40
 

   inc ebx
   CMP ebx,3
   JNE MakeDots8






ret
DrawDotsForLevelThree endp

DrawFoodForLevelThree proc


  mov esi,offset LevelThreeFoodDL      
	mov edi,offset LevelThreeFoodDH
	mov eax,brown (brown*16)
	call SetTextColor
	mov dl,2
	mov dh,11
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar

	mov dl,6
	mov dh,27
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar

	mov dl,46
	mov dh,21
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar

	mov dl,68
	mov dh,22
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar

	
	mov dl,66
	mov dh,10
	mov [esi],dl
	mov [edi],dh
	inc esi
	inc edi
	call Gotoxy
	mov al,"F"
	call WriteChar
	ret
DrawFoodForLevelThree endp


DrawEnemy2 proc

call DrawEnemy
mov eax,green (green*16)
	call SetTextColor
	mov dl,Enemy4XPos
	mov dh,Enemy4YPos
	call Gotoxy
	mov al,"G"
	call WriteChar

	mov eax,blue (blue*16)
	call SetTextColor
	mov dl,Enemy5XPos
	mov dh,Enemy5YPos
	call Gotoxy
	mov al,"G"
	call WriteChar

	ret
DrawEnemy2 endp

UpdateEnemyMovement2 proc

call UpdateEnemyMovement
mov eax,white(black*16)
call setTextColor

	mov dl,Enemy4XPos
	mov dh,Enemy4YPos
	call Gotoxy
	mov al," "
	call WriteChar

	mov dl,Enemy5XPos
	mov dh,Enemy5YPos
	call Gotoxy
	mov al," "
	call WriteChar


	ret
UpdateEnemyMovement2 endp


EnemyAndFruit3 proc                    

   ;;Working For First Enemy
      	mov esi,offset LevelThreeFoodDH
	    mov edi,offset  LevelThreeFoodDL               
	      mov ecx,lengthof  LevelThreeFoodDH
	      Iteration:                                          
	      mov bl,[edi]
	      CMP bl,Enemy1XPos
	     JE CheckYPos
	     tempLabel:
          inc edi
	       inc esi
	      loop Iteration
             JMP skip
	       CheckYPos:
	         mov al,[esi]
	        CMP al,Enemy1YPos
	        JE  DrawFruit             ;Fruit and Enemy has come on same x and y axis, so as enemy passes this location, Fruit reappears
	        JMP tempLabel
			
	      DrawFruit:
		  mov dh,Enemy1YPos
		  mov dl,Enemy1XPos
		  call gotoxy
		   mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
			 skip:
			;;Working For Second Enemy
			 	mov esi,offset LevelThreeFoodDH
	            mov edi,offset  LevelThreeFoodDL              
	      mov ecx,lengthof LevelThreeFoodDH
	      Iteration1:                                          
	      mov bl,[edi]
	      CMP bl,Enemy2XPos
	     JE CheckYPos1
	     tempLabel1:
          inc edi
	       inc esi
	      loop Iteration1
           JMP skip1
	       CheckYPos1:
	         mov al,[esi]
	        CMP al,Enemy2YPos
	        JE  DrawFruit1              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel1
		   DrawFruit1:
		  mov dh,Enemy2YPos
		  mov dl,Enemy2XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
		  skip1:

		  	mov esi,offset LevelThreeFoodDH
	    mov edi,offset  LevelThreeFoodDL             
	      mov ecx,lengthof LevelThreeFoodDH
	      Iteration2:                                          
	      mov bl,[edi]
	      CMP bl,Enemy3XPos
	     JE CheckYPos2
	     tempLabel2:
          inc edi
	       inc esi
	      loop Iteration2
           JMP skip2
	       CheckYPos2:
	         mov al,[esi]
	        CMP al,Enemy3YPos
	        JE  DrawFruit2             ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel2
		   DrawFruit2:
		  mov dh,Enemy3YPos
		  mov dl,Enemy3XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
          skip2:
		  	mov esi,offset LevelThreeFoodDH
	    mov edi,offset  LevelThreeFoodDL             
	      mov ecx,lengthof LevelThreeFoodDH
	      Iteration3:                                          
	      mov bl,[edi]
	      CMP bl,Enemy4XPos
	     JE CheckYPos3
	     tempLabel3:
          inc edi
	       inc esi
	      loop Iteration3
           JMP skip3
	       CheckYPos3:
	         mov al,[esi]
	        CMP al,Enemy4YPos
	        JE  DrawFruit3             ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel3
		   DrawFruit3:
		  mov dh,Enemy4YPos
		  mov dl,Enemy4XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar
			 skip3:
			  	mov esi,offset LevelThreeFoodDH
	    mov edi,offset  LevelThreeFoodDL             
	      mov ecx,lengthof LevelThreeFoodDH
	      Iteration4:                                          
	      mov bl,[edi]
	      CMP bl,Enemy5XPos
	     JE CheckYPos4
	     tempLabel4:
          inc edi
	       inc esi
	      loop Iteration4
           JMP skip4
	       CheckYPos4:
	         mov al,[esi]
	        CMP al,Enemy5YPos
	        JE  DrawFruit4             ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel4
		   DrawFruit4:
		  mov dh,Enemy5YPos
		  mov dl,Enemy5XPos
		  call gotoxy
		  mov eax,brown(brown*16)
		  call setTextColor
		     mov al,"F"
			 call WriteChar

			 skip4:
	ret
EnemyAndFruit3 endp



EnemyAndDot3 proc

          ;;Working For First Enemy
      	mov esi,offset DotsArrayLevelThreeDH
	    mov edi,offset  DotsArrayLevelThreeDL               
	      mov ecx,lengthof  DotsArrayLevelThreeDH
	      Iteration:                                          
	      mov bl,[edi]
	      CMP bl,Enemy1XPos
	     JE CheckYPos
	     tempLabel:
          inc edi
	       inc esi
	      loop Iteration
             JMP skip
	       CheckYPos:
	         mov al,[esi]
	        CMP al,Enemy1YPos
	        JE  DrawDot              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel
			
	      DrawDot:
		  mov dh,Enemy1YPos
		  mov dl,Enemy1XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
			 skip:
			;;Working For Second Enemy
			 	mov esi,offset  DotsArrayLevelThreeDH
	    mov edi,offset  DotsArrayLevelThreeDL              
	      mov ecx,lengthof  DotsArrayLevelThreeDH
	      Iteration1:                                          
	      mov bl,[edi]
	      CMP bl,Enemy2XPos
	     JE CheckYPos1
	     tempLabel1:
          inc edi
	       inc esi
	      loop Iteration1
           JMP skip1
	       CheckYPos1:
	         mov al,[esi]
	        CMP al,Enemy2YPos
	        JE  DrawDot1              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel1
		   DrawDot1:
		  mov dh,Enemy2YPos
		  mov dl,Enemy2XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
		  skip1:

		  	mov esi,offset  DotsArrayLevelThreeDH
	    mov edi,offset  DotsArrayLevelThreeDL             
	      mov ecx,lengthof  DotsArrayLevelThreeDH
	      Iteration2:                                          
	      mov bl,[edi]
	      CMP bl,Enemy3XPos
	     JE CheckYPos2
	     tempLabel2:
          inc edi
	       inc esi
	      loop Iteration2
           JMP skip2
	       CheckYPos2:
	         mov al,[esi]
	        CMP al,Enemy3YPos
	        JE  DrawDot2              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel2
		   DrawDot2:
		  mov dh,Enemy3YPos
		  mov dl,Enemy3XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
          skip2:

		  	mov esi,offset  DotsArrayLevelThreeDH
	    mov edi,offset  DotsArrayLevelThreeDL             
	      mov ecx,lengthof  DotsArrayLevelThreeDH
	      Iteration3:                                          
	      mov bl,[edi]
	      CMP bl,Enemy4XPos
	     JE CheckYPos3
	     tempLabel3:
          inc edi
	       inc esi
	      loop Iteration3
           JMP skip3
	       CheckYPos3:
	         mov al,[esi]
	        CMP al,Enemy4YPos
	        JE  DrawDot3              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel3
		   DrawDot3:
		  mov dh,Enemy4YPos
		  mov dl,Enemy4XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."
		  skip3:
		  
		  	mov esi,offset  DotsArrayLevelThreeDH
	    mov edi,offset  DotsArrayLevelThreeDL             
	      mov ecx,lengthof  DotsArrayLevelThreeDH
	      Iteration4:                                          
	      mov bl,[edi]
	      CMP bl,Enemy5XPos
	     JE CheckYPos4
	     tempLabel4:
          inc edi
	       inc esi
	      loop Iteration4
           JMP skip4
	       CheckYPos4:
	         mov al,[esi]
	        CMP al,Enemy5YPos
	        JE  DrawDot4              ;Dot and Enemy has come on same x and y axis, so as enemy passes this location, dots reappears
	        JMP tempLabel4
		   DrawDot4:
		  mov dh,Enemy5YPos
		  mov dl,Enemy5XPos
		  call gotoxy
		  mov al,15
		  call setTextColor
		  mWrite"."

		  skip4:
ret
EnemyAndDot3 endp

GenerateRandomPositionOfEnemy3 proc

mov eax,4
call RandomRange
inc eax
mov RandomNumber,al

CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
JMP here
M1:
dec Enemy1YPos          ; enemy will move upward
inc Enemy2YPos
dec Enemy3YPos
inc Enemy4YPos
dec Enemy5YPos
JMP here
M2:
inc Enemy1YPos        ; enemy will move downward
dec Enemy2YPos
inc Enemy3YPos 
dec Enemy4YPos        ; enemy will move downward
inc Enemy5YPos
JMP here
M3:
dec Enemy1XPos           ;enemy will move backward
inc Enemy2XPos 
dec Enemy3XPos
inc Enemy4XPos 
inc Enemy5XPos
JMP here
M4:
inc Enemy1XPos            ;enemy will move forward
dec Enemy2XPos
inc Enemy3XPos
dec Enemy4XPos            ;enemy will move forward
dec Enemy5XPos
here:
ret
GenerateRandomPositionOfEnemy3 endp


CheckPacmanEnemyCollision3 proc
 mov al,PlayerXPos
mov bl,PlayerYPos

CMP al,Enemy1XPos
JE CheckYPos1
CMP al,Enemy2XPos
JE CheckYPos2
CMP al,Enemy3XPos
JE CheckYPos3
CMP al,Enemy4XPos
JE CheckYPos4
CMP al,Enemy5XPos
JE CheckYPos5
JMP skip

CheckYPos1:
CMP bl,Enemy1YPos
JE ReduceLife
JMP skip
CheckYPos2:
CMP bl,Enemy2YPos
JE ReduceLife
JMP skip
CheckYPos3:
CMP bl,Enemy3YPos
JE ReduceLife
JMP skip
CheckYPos4:
CMP bl,Enemy4YPos
JE ReduceLife
JMP skip
CheckYPos5:
CMP bl,Enemy5YPos
JE ReduceLife

JMP skip

ReduceLife:
dec LivesAvailable

        mov dl,36
        mov dh,6
		call Gotoxy
		mov eax,red
		call setTextColor
	    mWrite "Lives Available :   "
	    mov al,LivesAvailable
	    call Writedec

		mov dl,34
        mov dh,7
		call Gotoxy
		mov eax,LightGray
		call setTextColor
	    mWrite "Oops!Live Lost"
	     call delay
		 call delay
		 call delay
		  call delay
		mov al,15
		call setTextColor
	   mov ecx,14
	   mov dl,34
	   mov dh,7
	   Remove:
	   call gotoxy
	   call delay
	   call delay
	   call delay
	   call delay
	   call delay
	   call delay
	   mWrite" "
	   inc dl
	   loop Remove
 
 mov PlayerXPos,4
 mov PlayerYPos,16


 skip:	  
ret

CheckPacmanEnemyCollision3 endp

Level3CheckEnemy1Collision proc

    mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy1XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy1YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis and y-axis  )
	JMP tempLabel
	ret
	CollisionDetected:        ;;;;;This label works when Enemey collides with walls ;;;;;;;
	mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy1YPos
    call DrawEnemy2               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	dec Enemy1YPos
    call DrawEnemy2              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
   inc Enemy1XPos
    call DrawEnemy2;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy1YPos
	mov dl,Enemy1XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    dec Enemy1XPos
    call DrawEnemy2


ret
Level3CheckEnemy1Collision endp


Level3CheckEnemy2Collision proc

    mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy2XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy2YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis and y-axis )
	JMP tempLabel
	ret
	CollisionDetected:         ;;;;;This label works when Enemey collides with walls ;;;;;;;
	mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy2YPos
    call DrawEnemy2               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	inc Enemy2YPos
    call DrawEnemy2              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy2XPos
    call DrawEnemy2;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy2YPos
	mov dl,Enemy2XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    inc Enemy2XPos
    call DrawEnemy2


ret
Level3CheckEnemy2Collision endp

Level3CheckEnemy3Collision proc

    mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy3XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy3YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axis and y-axis  )
	JMP tempLabel
	ret
	CollisionDetected:         ;;;;;This label works when Enemey collides with walls ;;;;;;;
	mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
     mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy3YPos
    call DrawEnemy2               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	dec Enemy3YPos
    call DrawEnemy2              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy3XPos
    call DrawEnemy2;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy3YPos
	mov dl,Enemy3XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    dec Enemy3XPos
    call DrawEnemy2


ret
Level3CheckEnemy3Collision endp

Level3CheckEnemy4Collision proc

    mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy4XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy4YPos
	JE  CollisionDetected               ;collisionDetected    (Player Collides at x-axi and y-axis )
	JMP tempLabel
	ret
	CollisionDetected:         ;;;;;This label works when Enemey collides with walls ;;;;;;;
	mov dh,Enemy4YPos
	mov dl,Enemy4XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
     mov dh,Enemy4YPos
	mov dl,Enemy4XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy4YPos
    call DrawEnemy2               
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy4YPos
	mov dl,Enemy4XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	inc Enemy4YPos
    call DrawEnemy2             
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy4YPos
	mov dl,Enemy4XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy4XPos
    call DrawEnemy2;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy4YPos
	mov dl,Enemy4XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
    inc Enemy4XPos
    call DrawEnemy2


ret
Level3CheckEnemy4Collision endp


Level3CheckEnemy5Collision proc

    mov esi,offset LevelThreeArrayDH
	mov edi,offset LevelThreeArrayDL               
	mov ecx,lengthof LevelThreeArrayDL
	OuterLoop:                                          
	mov bl,[edi]
	CMP bl,Enemy5XPos
	JE CheckYPos
	tempLabel:
     inc edi
	 inc esi
	loop OuterLoop
        ret
	CheckYPos:
	mov al,[esi]
	CMP al,Enemy5YPos
	JE  CollisionDetected               ;collisionDetected    (Enemy Collides at x-axis  and y-axis )
	JMP tempLabel
	ret
	CollisionDetected:       ;;;;;This label works when Enemey collides with walls ;;;;;;;
	mov dh,Enemy5YPos
	mov dl,Enemy5XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	
CMP RandomNumber,1
JE M1
CMP RandomNumber,2
JE M2
CMP RandomNumber,3
JE M3
CMP RandomNumber,4
JE M4
ret
M1:
call UpdateEnemyMovement
     mov dh,Enemy5YPos
	mov dl,Enemy5XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     inc Enemy5YPos
    call DrawEnemy2              
ret
M2:
call UpdateEnemyMovement
    mov dh,Enemy5YPos
	mov dl,Enemy5XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
	dec Enemy5YPos
    call DrawEnemy2              
ret
M3:
    call UpdateEnemyMovement  
    mov dh,Enemy5YPos
	mov dl,Enemy5XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
     dec Enemy5XPos
    call DrawEnemy2;enemy will move backward
ret
M4:
    call UpdateEnemyMovement
    mov dh,Enemy5YPos
	mov dl,Enemy5XPos
	call gotoxy
	mov eax,blue
	call setTextColor
	mWrite"#"
   inc Enemy5XPos
    call DrawEnemy2
ret
Level3CheckEnemy5Collision endp


DrawHiddenPaths proc

mov eax,LightGray (LightGray*16)
	call SetTextColor
	mov dl,HiddenPathX1
	mov dh,HiddenPathY1
	call Gotoxy
	mov al,"H"
	call WriteChar

	mov eax,LightGray (LightGray*16)
	call SetTextColor
	mov dl,HiddenPathX2
	mov dh,HiddenPathY2
	call Gotoxy
	mov al,"H"
	call WriteChar

	mov eax,LightGray (LightGray*16)
	call SetTextColor
	mov dl,HiddenPathX3
	mov dh,HiddenPathY3
	call Gotoxy
	mov al,"H"
	call WriteChar

	mov eax,LightGray (LightGray*16)
	call SetTextColor
	mov dl,HiddenPathX4
	mov dh,HiddenPathY4
	call Gotoxy
	mov al,"H"
	call WriteChar

	ret
DrawHiddenPaths endp


DisplayEnd proc

call DisplayWin

 mov dh,19
 mov dl,43
 call gotoxy
 mov eax,cyan
 call setTextColor
 mWrite"Whoo!!,You are Champ!!!, All Three Levels Cleared",0
 mov eax,1500
 call delay
 ret

DisplayEnd endp


DrawTeleportation proc
    

	;;Dark Grey Color
	mov eax,8(8*16)
	call SetTextColor
	mov dl,TeleportationPathX1
	mov dh,TeleportationPathY1
	call Gotoxy
	mov al,"T"
	call WriteChar

	mov eax,8(8*16)
	call SetTextColor
	mov dl,TeleportationPathX2
	mov dh,TeleportationPathY2
	call Gotoxy
	mov al,"G"
	call WriteChar

	mov al,15
	call setTextColor


	ret
DrawTeleportation endp


                                              ;;;Following Procedure will allow enemies to teleport too;;;;;;;;;;
EnemyAndTeleportationPath proc                               

    mov al,Enemy1XPos
	mov bl,Enemy1YPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport1
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport1
	call UpdateEnemyMovement
	mov Enemy1XPos,2
	mov Enemy1YPos,19
	call DrawEnemy2

	CheckNextTeleport1:
	mov al,Enemy1XPos
	mov bl,Enemy1YPos
	CMP al,TeleportationPathX2
	JNE CheckNextTeleport2
	CMP bl,TeleportationPathY2
	JNE CheckNextTeleport2
	call UpdateEnemyMovement
	mov Enemy1XPos,78
	mov Enemy1YPos,19
	call DrawEnemy2

	CheckNextTeleport2:
	 mov al,Enemy2XPos
	mov bl,Enemy2YPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport3
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport3
	call UpdateEnemyMovement
	mov Enemy2XPos,2
	mov Enemy2YPos,19
	call DrawEnemy2

	CheckNextTeleport3:
	mov al,Enemy2XPos
	mov bl,Enemy2YPos
	CMP al,TeleportationPathX2
	JNE CheckNextTeleport4
	CMP bl,TeleportationPathY2
	JNE CheckNextTeleport4
	call UpdateEnemyMovement
	mov Enemy2XPos,78
	mov Enemy2YPos,19
	call DrawEnemy2



	CheckNextTeleport4:
	 mov al,Enemy3XPos
	mov bl,Enemy3YPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport5
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport5
	call UpdateEnemyMovement
	mov Enemy3XPos,2
	mov Enemy3YPos,19
	call DrawEnemy2

	CheckNextTeleport5:
	mov al,Enemy3XPos
	mov bl,Enemy3YPos
	CMP al,TeleportationPathX2
	JNE CheckNextTeleport6
	CMP bl,TeleportationPathY2
	JNE CheckNextTeleport6
	call UpdateEnemyMovement
	mov Enemy3XPos,78
	mov Enemy3YPos,19
	call DrawEnemy2


	CheckNextTeleport6:
	 mov al,Enemy4XPos
	mov bl,Enemy4YPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport7
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport7
	call UpdateEnemyMovement
	mov Enemy4XPos,2
	mov Enemy4YPos,19
	call DrawEnemy2

	CheckNextTeleport7:
	mov al,Enemy4XPos
	mov bl,Enemy4YPos
	CMP al,TeleportationPathX2
	JNE CheckNextTeleport8
	CMP bl,TeleportationPathY2
	JNE CheckNextTeleport8
	call UpdateEnemyMovement
	mov Enemy4XPos,78
	mov Enemy4YPos,19
	call DrawEnemy2

	CheckNextTeleport8:
	 mov al,Enemy5XPos
	mov bl,Enemy5YPos
	CMP al,TeleportationPathX1
	JNE CheckNextTeleport9
	CMP bl,TeleportationPathY1
	JNE CheckNextTeleport9
	call UpdateEnemyMovement
	mov Enemy5XPos,2
	mov Enemy5YPos,19
	call DrawEnemy2

	CheckNextTeleport9:
	mov al,Enemy5XPos
	mov bl,Enemy5YPos
	CMP al,TeleportationPathX2
	JNE CheckNextTeleport10
	CMP bl,TeleportationPathY2
	JNE CheckNextTeleport10
	call UpdateEnemyMovement
	mov Enemy5XPos,78
	mov Enemy5YPos,19
	call DrawEnemy2

	CheckNextTeleport10:
	ret

EnemyAndTeleportationPath endp





     invoke ExitProcess,0
  END main



